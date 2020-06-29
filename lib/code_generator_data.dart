import 'package:meta/meta.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';

import 'code_generator_helpers.dart';

@immutable
class ClassInfo {
  final String name;
  final Iterable<TypeParameterInfo> typeParameters;
  final bool isPrivate;
  final bool isMutable;
  final ConstructorInfo constructor;

  const ClassInfo({
    @required this.name,
    @required this.typeParameters,
    @required this.isPrivate,
    @required this.isMutable,
    @required this.constructor,
  });
}

@immutable
class ConstructorInfo {
  final String name;
  final bool isPrivate;
  final Iterable<ParameterInfo> parameters;

  const ConstructorInfo({
    @required this.name,
    @required this.isPrivate,
    @required this.parameters,
  });
}

@immutable
class ParameterInfo {
  final String name;
  final String type;
  final bool isRequired;
  final bool isNamed;
  final bool isNullable;

  const ParameterInfo({
    @required this.name,
    @required this.type,
    @required this.isRequired,
    @required this.isNamed,
    @required this.isNullable,
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

String generateDataClass(Element element) {
  final dataClass = element as ClassElement;

  final constructors =
      dataClass.constructors.where((c) => !c.isDefaultConstructor);

  if (constructors.isEmpty) {
    throw InvalidGenerationSourceErrorWithTodo(
      'The data class must contain at least one non-default constructor.',
      todo: 'Add a constructor.',
      element: dataClass,
    );
  }

  final primaryConstructors = constructors.length > 1
      ? constructors
          .where((c) => c.metadata.any((m) => m.element.name == 'primary'))
      : constructors;

  if (primaryConstructors.isEmpty) {
    throw InvalidGenerationSourceErrorWithTodo(
      'If you use more than one constructor, one of them must be annotated with @primary.',
      todo: 'Add @primary for one of them or leave one constructor.',
      element: dataClass,
    );
  }

  if (primaryConstructors.length > 1) {
    throw InvalidGenerationSourceErrorWithTodo(
      'Only one constructor can be annotated with @primary.',
      todo: 'Delete @primary for other constructors.',
      element: dataClass,
    );
  }

  final primaryConstructor = primaryConstructors.first;

  final parameters = primaryConstructor.parameters.map((p) {
    final isRequired =
        p.isNotOptional || p.metadata.any((e) => e.element.name == 'required');

    final isNullable = p.metadata.any((e) => e.element.name == 'nullable');

    return ParameterInfo(
      name: p.name,
      type: p.type.getDisplayString(),
      isRequired: isRequired,
      isNamed: p.isNamed,
      isNullable: isNullable,
    );
  });

  if (parameters.isEmpty) {
    throw InvalidGenerationSourceErrorWithTodo(
      'The primary constructor must contain at least one parameter.',
      todo: 'Add a parameter.',
      element: primaryConstructor,
    );
  }

  final typeParameters = dataClass.typeParameters.map((tp) => TypeParameterInfo(
        name: tp.displayName,
        bound: tp.bound != null ? tp.bound.toString() : '',
      ));

  final isMutable = dataClass.metadata.any((e) => e.element.name == 'mutable');

  final classInfo = ClassInfo(
    name: dataClass.displayName,
    typeParameters: typeParameters,
    isPrivate: dataClass.isPrivate,
    isMutable: isMutable,
    constructor: ConstructorInfo(
      name: primaryConstructor.name,
      isPrivate: primaryConstructor.isPrivate,
      parameters: parameters,
    ),
  );

  return createDataClass(classInfo);
}

String createDataClass(ClassInfo classInfo) {
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

  // final asserts = classInfo.constructor.parameters
  //     .where((p) => !p.isNullable)
  //     .map((p) => Code('assert(${p.name} != null)'));

  final mixinMethods = [
    createThis(classInfo, classNameWithTypeParameters),
    createEquals(classInfo, classNameWithTypeParameters),
    createHashCode(classInfo),
    createToString(classInfo),
  ];

  final extensionMethods = [
    createCopyWith(classInfo, typeParameters, classNameWithTypeParameters),
  ];

  final dataClassMixinName = '_\$${classInfo.name}';

  final dataClassExtensionName =
      classInfo.isPrivate || classInfo.constructor.isPrivate
          ? '_\$\$${classInfo.name}'
          : '\$\$${classInfo.name}';

  final emitter = DartEmitter();

  final dataClassMixin = Class(
    (b) => b
      ..annotations
          .addAll([if (!classInfo.isMutable) const Reference('immutable')])
      ..name = dataClassMixinName
      ..types.addAll(typeParametersWithBounds)
      ..methods.addAll(mixinMethods),
  ).accept(emitter).toString().replaceFirst('class', 'mixin');

  final dataClassExtension = Class(
    (b) => b
      ..name = dataClassExtensionName
      ..types.addAll(typeParametersWithBounds)
      ..implements.add(classNameWithTypeParameters)
      ..methods.addAll(extensionMethods),
  )
      .accept(emitter)
      .toString()
      .replaceFirst('class', 'extension')
      .replaceFirst(' implements ', ' on ');

  const stars =
      '// **************************************************************************\n';

  final marker =
      '$stars// ${classNameWithTypeParametersAndBounds.accept(emitter)}\n$stars';

  return marker + dataClassMixin + dataClassExtension;
}

Method createThis(
  ClassInfo classInfo,
  TypeReference classNameWithTypeParameters,
) {
  final body = const Reference('this').asA(classNameWithTypeParameters).code;

  return Method(
    (b) => b
      ..name = '_this'
      ..type = MethodType.getter
      ..lambda = true
      ..returns = classNameWithTypeParameters
      ..body = body,
  );
}

Method createHashCode(ClassInfo classInfo) {
  final body = Block(
    (b) => b
      ..statements.addAll([
        const Reference('_this').assignFinal('\$this').statement,
        const Reference('DeepCollectionEquality')
            .constInstance([])
            .property('hash')
            .call([
              literalList([
                const Reference('runtimeType').property('hashCode'),
                ...classInfo.constructor.parameters
                    .map((p) => const Reference('\$this').property(p.name))
              ]),
            ])
            .returned
            .statement
      ]),
  );

  return Method(
    (b) => b
      ..annotations.add(const Reference('override'))
      ..name = 'hashCode'
      ..type = MethodType.getter
      ..returns = const Reference('int')
      ..body = body,
  );
}

Method createEquals(
  ClassInfo classInfo,
  TypeReference classNameWithTypeParameters,
) {
  final body = Block(
    (b) => b
      ..statements.addAll([
        const Reference('_this').assignFinal('\$this').statement,
        const Reference('identical')
            .call([const Reference('this'), const Reference('other')])
            .or(const Reference('other')
                .isA(classNameWithTypeParameters)
                // .and(const Reference('identical').call([
                //   const Reference('this').property('runtimeType'),
                //   const Reference('other').property('runtimeType')
                // ]))
                .and(const Reference('DeepCollectionEquality')
                    .constInstance([])
                    .property('equals')
                    .call([
                      literalList(classInfo.constructor.parameters.map(
                          (p) => const Reference('\$this').property(p.name))),
                      literalList(classInfo.constructor.parameters.map(
                          (p) => const Reference('other').property(p.name))),
                    ])))
            .returned
            .statement
      ]),
  );

  return Method(
    (b) => b
      ..annotations.add(const Reference('override'))
      ..name = 'operator =='
      ..returns = const Reference('bool')
      ..requiredParameters.add(
        Parameter((b) => b
          ..type = const Reference('Object')
          ..name = 'other'),
      )
      ..body = body,
  );
}

Method createToString(ClassInfo classInfo) {
  String escape$(String value) => value.replaceAll('\$', '\\\$');

  final className = escape$(classInfo.name);

  final typeParametersString =
      classInfo.typeParameters.map((tp) => '\${${tp.name}}').join(', ');

  final parametersString = classInfo.constructor.parameters
      .map((p) => '${escape$(p.name)}: \${\$this.${p.name}}')
      .join(', ');

  final returnString = classInfo.typeParameters.isNotEmpty
      ? '\'$className<$typeParametersString>($parametersString)\''
      : '\'$className($parametersString)\'';

  final body = Block(
    (b) => b
      ..statements.addAll([
        const Reference('_this').assignFinal('\$this').statement,
        Reference(returnString).returned.statement
      ]),
  );

  return Method(
    (b) => b
      ..annotations.add(const Reference('override'))
      ..name = 'toString'
      ..returns = const Reference('String')
      ..body = body,
  );
}

Method createCopyWith(
  ClassInfo classInfo,
  Iterable<Reference> typeParameters,
  TypeReference classNameWithTypeParameters,
) {
  final name = classInfo.isPrivate || classInfo.constructor.isPrivate
      ? '_copyWith'
      : 'copyWith';

  final constructorName =
      classInfo.constructor.name.isNotEmpty ? classInfo.constructor.name : null;

  if (classInfo.constructor.parameters.any((p) => p.isNullable)) {
    final returns = FunctionType(
      (b) => b
        ..returnType = classNameWithTypeParameters
        ..namedParameters.addAll(
          Map.fromEntries(classInfo.constructor.parameters.map((p) => MapEntry(
                p.name,
                Reference(p.type),
              ))),
        ),
    );

    final body = Method(
      (b) => b
        ..lambda = true
        ..optionalParameters
            .addAll(classInfo.constructor.parameters.map((p) => p.isNullable
                ? Parameter(
                    (b) => b
                      ..name = p.name
                      ..named = true
                      ..type = const Reference('Object')
                      ..defaultTo = const Code('unused'),
                  )
                : Parameter(
                    (b) => b
                      ..name = p.name
                      ..named = true,
                  )))
        ..body = Reference(classInfo.name)
            .newInstanceNamed(
              constructorName,
              classInfo.constructor.parameters.where((p) => !p.isNamed).map(
                  (p) => p.isNullable
                      ? Reference(p.name)
                          .equalTo(const Reference('unused'))
                          .conditional(const Reference('this').property(p.name),
                              Reference(p.name).asA(Reference(p.type)))
                      : Reference(p.name).ifNullThen(
                          const Reference('this').property(p.name))),
              Map.fromEntries(classInfo.constructor.parameters
                  .where((p) => p.isNamed)
                  .map((p) => MapEntry(
                        p.name,
                        p.isNullable
                            ? Reference(p.name).ifNullThen(
                                const Reference('this').property(p.name))
                            : Reference(p.name).ifNullThen(
                                const Reference('this').property(p.name)),
                      ))),
            )
            .code,
    ).closure.code;

    return Method(
      (b) => b
        ..name = name
        ..returns = returns
        ..type = MethodType.getter
        ..lambda = true
        ..body = body,
    );
  }

  final parameters = classInfo.constructor.parameters.map((p) => Parameter(
        (b) => b
          ..name = p.name
          ..named = true
          ..type = Reference(p.type),
      ));

  final body = Reference(classInfo.name)
      .newInstanceNamed(
        constructorName,
        classInfo.constructor.parameters.where((p) => !p.isNamed).map((p) =>
            Reference(p.name)
                .ifNullThen(const Reference('this').property(p.name))),
        Map.fromEntries(classInfo.constructor.parameters
            .where((p) => p.isNamed)
            .map((p) => MapEntry(
                  p.name,
                  Reference(p.name)
                      .ifNullThen(const Reference('this').property(p.name)),
                ))),
      )
      .code;

  return Method(
    (b) => b
      ..name = name
      ..returns = classNameWithTypeParameters
      ..optionalParameters.addAll(parameters)
      ..lambda = true
      ..body = body,
  );
}
