import 'package:meta/meta.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';

import 'adt_generator_helpers.dart';

@immutable
class ClassInfo {
  final String name;
  final Iterable<TypeParameterInfo> typeParameters;
  final Iterable<ConstructorInfo> constructors;
  final bool mayHaveAdditionalMembers;

  const ClassInfo({
    @required this.name,
    @required this.typeParameters,
    @required this.constructors,
    @required this.mayHaveAdditionalMembers,
  });
}

@immutable
class ConstructorInfo {
  final String name;
  final ParameterInfo parameter;

  const ConstructorInfo({
    @required this.name,
    @required this.parameter,
  });
}

@immutable
class ParameterInfo {
  final String name;
  final String type;
  final String defaultValue;
  final bool isNullable;
  final bool isOptional;

  const ParameterInfo({
    @required this.name,
    @required this.type,
    @required this.defaultValue,
    @required this.isNullable,
    @required this.isOptional,
  });
}

@immutable
class TypeParameterInfo {
  final String name;
  final String bound;

  const TypeParameterInfo({
    @required this.name,
    this.bound,
  });
}

String generateUnionClass(Element element) {
  final unionClass = element as ClassElement;

  final constructors = unionClass.constructors
      .where((c) => c.isFactory && c.isPublic && c.name.isNotEmpty);

  if (constructors.isEmpty) {
    throw InvalidGenerationSourceErrorWithTodo(
      'The Union class must contain at least one named factory constructor.',
      todo: 'Add a named factory constructor.',
      element: unionClass,
    );
  }

  final mayHaveAdditionalMembers = unionClass.constructors
      .where((c) => c.isConst && c.name == '_' && c.parameters.isEmpty)
      .isNotEmpty;

  if (unionClass.constructors.length >
      constructors.length + (mayHaveAdditionalMembers ? 1 : 0)) {
    throw InvalidGenerationSourceErrorWithTodo(
      'The Union class must contain only public named factory constructors or "const ${unionClass.displayName}._()" constructor.',
      todo: 'Delete other constructors.',
      element: unionClass,
    );
  }

  final constructorsInfo = constructors.map((c) {
    if (c.parameters.length > 1) {
      throw InvalidGenerationSourceErrorWithTodo(
        'Each factory constructor must contain zero or one parameter.',
        todo: 'Delete other parameters.',
        element: c,
      );
    }

    final parameter = c.parameters.isNotEmpty
        ? () {
            final parameter = c.parameters.first;

            if (parameter.isNamed) {
              throw InvalidGenerationSourceErrorWithTodo(
                'The factory constructor can contain only a required or optional positional parameter.',
                todo: 'Make this parameter positional.',
                element: parameter,
              );
            }

            final isNullable =
                parameter.metadata.any((e) => e.element.name == 'nullable');

            final isOptional = parameter.isOptionalPositional;

            final defaultAnnotation = parameter.metadata
                .firstWhere(
                    (m) => m.element
                        .getDisplayString(withNullability: false)
                        .startsWith('Default '),
                    orElse: () => null)
                ?.toSource();

            final defaultValueRaw = defaultAnnotation?.substring(
                '@Default('.length, defaultAnnotation.length - 1);

            final defaultValue = defaultValueRaw != null &&
                    !defaultValueRaw.startsWith('const ') &&
                    (defaultValueRaw.endsWith(')') ||
                        defaultValueRaw.endsWith(']') ||
                        defaultValueRaw.endsWith('}'))
                ? 'const $defaultValueRaw'
                : defaultValueRaw;

            if (!isOptional && defaultValue != null) {
              throw InvalidGenerationSourceErrorWithTodo(
                'The required parameter must not be annotated with @Default.',
                todo:
                    'Remove @Default or make this parameter optional positional.',
                element: parameter,
              );
            }

            if (!isNullable && isOptional && defaultValue == null) {
              throw InvalidGenerationSourceErrorWithTodo(
                'The non-nullable optional positional parameter must be annotated with @Default.',
                todo:
                    'Add @Default or make this parameter required or nullable.',
                element: parameter,
              );
            }

            if (!isNullable && defaultValue == 'null') {
              throw InvalidGenerationSourceErrorWithTodo(
                '@Default value cannot be null for a non-nullable parameter.',
                todo: 'Use a non-null value or make this parameter nullable.',
                element: parameter,
              );
            }

            return ParameterInfo(
              name: parameter.name,
              type: parameter.type.getDisplayString(withNullability: false),
              defaultValue: defaultValue,
              isNullable: isNullable,
              isOptional: isOptional,
            );
          }()
        : null;

    return ConstructorInfo(
      name: c.name,
      parameter: parameter,
    );
  });

  final typeParameters =
      unionClass.typeParameters.map((tp) => TypeParameterInfo(
            name: tp.displayName,
            bound: tp.bound?.getDisplayString(withNullability: false) ?? '',
          ));

  final classInfo = ClassInfo(
    name: unionClass.displayName,
    typeParameters: typeParameters,
    constructors: constructorsInfo,
    mayHaveAdditionalMembers: mayHaveAdditionalMembers,
  );

  return createUnionClass(classInfo);
}

String createUnionClass(ClassInfo classInfo) {
  final typeParameters =
      classInfo.typeParameters.map((tp) => Reference(tp.name));

  final typeParametersWithBounds =
      classInfo.typeParameters.map((tp) => TypeReference(
            (b) => b
              ..symbol = tp.name
              ..bound = tp.bound.isEmpty ? null : Reference(tp.bound),
          ));

  final classNameWithTypeParameters = TypeReference(
    (b) => b
      ..symbol = classInfo.name
      ..types.addAll(typeParameters),
  );

  final classNameWithTypeParametersAndBounds = TypeReference(
    (b) => b
      ..symbol = classInfo.name
      ..types.addAll(typeParametersWithBounds),
  );

  final unionClassBehindName = '_\$${classInfo.name}';

  final unionClassExtensionName = '\$\$${classInfo.name}';

  final unionClassBehindNameWithTypeParameters = TypeReference(
    (b) => b
      ..symbol = unionClassBehindName
      ..types.addAll(typeParameters),
  );

  final emitter = DartEmitter();

  final unionClassExtension = Class(
    (b) => b
      ..name = unionClassExtensionName
      ..types.addAll(typeParametersWithBounds)
      ..implements.add(classNameWithTypeParameters)
      ..methods.addAll([
        createMatchForUnionClassExtension(
          classInfo,
          unionClassBehindNameWithTypeParameters,
        ),
        createMatchForUnionClassExtension(
          classInfo,
          unionClassBehindNameWithTypeParameters,
          hasDefault: true,
        )
      ]),
  )
      .accept(emitter)
      .toString()
      .replaceFirst('class', 'extension')
      .replaceFirst(' implements ', ' on ');

  final unionClassBehind = Class(
    (b) => b
      ..annotations.add(const Reference('immutable'))
      ..abstract = true
      ..name = unionClassBehindName
      ..types.addAll(typeParametersWithBounds)
      ..implements.addAll([
        if (!classInfo.mayHaveAdditionalMembers) classNameWithTypeParameters
      ])
      ..extend = classInfo.mayHaveAdditionalMembers
          ? classNameWithTypeParameters
          : null
      ..constructors.addAll([
        if (classInfo.mayHaveAdditionalMembers)
          Constructor(
            (b) => b
              ..constant = true
              ..initializers.add(const Code('super._()')),
          ),
        ...classInfo.constructors.map((c) {
          final parameter = c.parameter != null
              ? [
                  Parameter(
                    (b) => b
                      ..name = c.parameter.name
                      ..type = Reference(c.parameter.type),
                  )
                ]
              : <Parameter>[];

          final isOptional = c.parameter?.isOptional ?? false;

          return Constructor(
            (b) => b
              ..constant = true
              ..name = c.name
              ..factory = true
              ..redirect = TypeReference(
                (b) => b
                  ..symbol = getUionCaseName(
                    unionClassBehindName: unionClassBehindName,
                    constructorName: c.name,
                  )
                  ..types.addAll(typeParameters),
              )
              ..requiredParameters.addAll([if (!isOptional) ...parameter])
              ..optionalParameters.addAll([if (isOptional) ...parameter]),
          );
        })
      ])
      ..methods.addAll([
        createMatchForClassBehind(classInfo),
        createMatchForClassBehind(classInfo, hasDefault: true),
      ]),
  ).accept(emitter).toString();

  final unionCases = classInfo.constructors.map((c) {
    final uionCaseName = getUionCaseName(
      unionClassBehindName: unionClassBehindName,
      constructorName: c.name,
    );

    final uionCaseNameWithTypeParameters = TypeReference(
      (b) => b
        ..symbol = uionCaseName
        ..types.addAll(typeParameters),
    );

    final methods = [
      createMatchForUnionCase(classInfo, c),
      createMatchForUnionCase(classInfo, c, hasDefault: true),
      createEquals(c, uionCaseNameWithTypeParameters),
      createHashCode(c),
      createToString(classInfo, c),
    ];

    final parameter = c.parameter != null
        ? [
            Parameter(
              (b) => b
                ..toThis = true
                ..name = '_${c.parameter.name}'
                ..defaultTo = Code(c.parameter.defaultValue),
            )
          ]
        : <Parameter>[];

    final isOptional = c.parameter?.isOptional ?? false;

    return Class(
      (b) => b
        ..name = uionCaseName
        ..types.addAll(typeParametersWithBounds)
        ..implements.addAll([
          if (!classInfo.mayHaveAdditionalMembers)
            unionClassBehindNameWithTypeParameters
        ])
        ..extend = classInfo.mayHaveAdditionalMembers
            ? unionClassBehindNameWithTypeParameters
            : null
        ..constructors.add(Constructor(
          (b) => b
            ..constant = true
            ..requiredParameters.addAll([if (!isOptional) ...parameter])
            ..optionalParameters.addAll([if (isOptional) ...parameter])
            ..initializers.addAll([
              if (c.parameter != null && !c.parameter.isNullable)
                CodeExpression(Code('assert(_${c.parameter.name} != null)'))
                    .code
            ]),
        ))
        ..fields.addAll([
          if (c.parameter != null)
            Field(
              (b) => b
                ..type = Reference(c.parameter.type)
                ..name = '_${c.parameter.name}'
                ..modifier = FieldModifier.final$,
            )
        ])
        ..methods.addAll(methods),
    ).accept(emitter).toString();
  }).join();

  final header =
      '$stars// ${classNameWithTypeParametersAndBounds.accept(emitter)}\n$stars';

  return header + unionClassExtension + unionClassBehind + unionCases;
}

String getUionCaseName({String unionClassBehindName, String constructorName}) =>
    '$unionClassBehindName\$$constructorName';

Method createHashCode(ConstructorInfo constructor) {
  final body = (constructor.parameter != null
          ? const Reference('DeepCollectionEquality')
              .constInstance([])
              .property('hash')
              .call([
                literalList([
                  const Reference('runtimeType').property('hashCode'),
                  Reference('_${constructor.parameter.name}'),
                ]),
              ])
          : const Reference('runtimeType').property('hashCode'))
      .code;

  return Method(
    (b) => b
      ..annotations.add(const Reference('override'))
      ..name = 'hashCode'
      ..type = MethodType.getter
      ..lambda = true
      ..returns = const Reference('int')
      ..body = body,
  );
}

Method createEquals(
  ConstructorInfo constructor,
  TypeReference classNameWithTypeParameters,
) {
  final bodyFirstPart = const Reference('identical')
      .call([const Reference('this'), const Reference('other')])
      .or(const Reference('other').isA(classNameWithTypeParameters))
      .and(const Reference('identical').call([
        const Reference('runtimeType'),
        const Reference('other').property('runtimeType'),
      ]));

  final body = (constructor.parameter != null
          ? bodyFirstPart.and(const Reference('DeepCollectionEquality')
              .constInstance([])
              .property('equals')
              .call([
                literalList([Reference('_${constructor.parameter.name}')]),
                literalList([
                  const Reference('other')
                      .property('_${constructor.parameter.name}')
                ]),
              ]))
          : bodyFirstPart)
      .code;

  return Method(
    (b) => b
      ..annotations.add(const Reference('override'))
      ..name = 'operator =='
      ..lambda = true
      ..returns = const Reference('bool')
      ..requiredParameters.add(
        Parameter((b) => b
          ..type = const Reference('Object')
          ..name = 'other'),
      )
      ..body = body,
  );
}

Method createToString(
  ClassInfo classInfo,
  ConstructorInfo constructor,
) {
  String escape$(String value) => value.replaceAll('\$', '\\\$');

  final className = escape$(classInfo.name);

  final typeParametersString =
      classInfo.typeParameters.map((tp) => '\${${tp.name}}').join(', ');

  final constructorName = escape$(constructor.name);

  final parameterName =
      constructor.parameter != null ? '\${_${constructor.parameter.name}}' : '';

  final returnString = classInfo.typeParameters.isNotEmpty
      ? '\'$className<$typeParametersString>.$constructorName($parameterName)\''
      : '\'$className.$constructorName($parameterName)\'';

  final body = Reference(returnString).code;

  return Method(
    (b) => b
      ..annotations.add(const Reference('override'))
      ..name = 'toString'
      ..lambda = true
      ..returns = const Reference('String')
      ..body = body,
  );
}

Method createMatchForUnionClassExtension(
  ClassInfo classInfo,
  TypeReference unionClassBehindNameWithTypeParameters, {
  bool hasDefault = false,
}) =>
    Method(
      (b) => b
        ..name = hasDefault ? 'matchOrDefault' : 'match'
        ..types.add(const Reference('ReturnType'))
        ..returns = const Reference('ReturnType')
        ..optionalParameters
            .addAll(createParametersForMatch(classInfo, hasDefault: hasDefault))
        ..body = Block(
          (b) => b
            ..statements.addAll([
              ...(hasDefault
                  ? [
                      const CodeExpression(Code('assert(orDefault != null)'))
                          .statement
                    ]
                  : classInfo.constructors.map((c) =>
                      CodeExpression(Code('assert(${c.name} != null)'))
                          .statement)),
              const Reference('this')
                  .asA(unionClassBehindNameWithTypeParameters)
                  .property(hasDefault ? 'matchOrDefault' : 'match')
                  .call(
                    [],
                    {
                      ...(Map.fromEntries(
                          classInfo.constructors.map((c) => MapEntry(
                                c.name,
                                Reference(c.name),
                              )))),
                      if (hasDefault) 'orDefault': const Reference('orDefault'),
                    },
                  )
                  .returned
                  .statement
            ]),
        ),
    );

Method createMatchForClassBehind(
  ClassInfo classInfo, {
  bool hasDefault = false,
}) =>
    Method((b) => b
      ..name = hasDefault ? 'matchOrDefault' : 'match'
      ..types.add(const Reference('ReturnType'))
      ..returns = const Reference('ReturnType')
      ..lambda = false
      ..optionalParameters
          .addAll(createParametersForMatch(classInfo, hasDefault: hasDefault)));

Method createMatchForUnionCase(
  ClassInfo classInfo,
  ConstructorInfo constructor, {
  bool hasDefault = false,
}) {
  final callThisCase = Reference(constructor.name).call([
    if (constructor.parameter != null)
      Reference('_${constructor.parameter.name}')
  ]);

  return Method(
    (b) => b
      ..annotations.add(const Reference('override'))
      ..name = hasDefault ? 'matchOrDefault' : 'match'
      ..types.add(const Reference('ReturnType'))
      ..returns = const Reference('ReturnType')
      ..lambda = true
      ..optionalParameters
          .addAll(createParametersForMatch(classInfo, hasDefault: hasDefault))
      ..body = (hasDefault
              ? Reference(constructor.name).notEqualTo(literalNull).conditional(
                    callThisCase,
                    const Reference('orDefault').call([]),
                  )
              : callThisCase)
          .code,
  );
}

Iterable<Parameter> createParametersForMatch(
  ClassInfo classInfo, {
  bool hasDefault = false,
}) =>
    [
      ...classInfo.constructors.map((c) => Parameter(
            (b) => b
              ..annotations
                  .addAll([if (!hasDefault) const Reference('required')])
              ..name = c.name
              ..named = true
              ..type = FunctionType(
                (b) => b
                  ..requiredParameters.addAll(
                      [if (c.parameter != null) Reference(c.parameter.type)])
                  ..returnType = const Reference('ReturnType'),
              ),
          )),
      if (hasDefault)
        Parameter(
          (b) => b
            ..annotations.add(const Reference('required'))
            ..name = 'orDefault'
            ..named = true
            ..type = FunctionType(
              (b) => b..returnType = const Reference('ReturnType'),
            ),
        )
    ];
