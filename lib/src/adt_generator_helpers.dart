import 'package:meta/meta.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

final stars = '// ${'*' * 77}\n';

@immutable
class InvalidGenerationSourceErrorWithTodo
    extends InvalidGenerationSourceError {
  InvalidGenerationSourceErrorWithTodo(String message,
      {String todo, Element element})
      : super(message, todo: todo, element: element);

  @override
  String toString() => '${super.toString()}\n$todo\n';
}

// https://github.com/dart-lang/code_builder/issues/288
class DartEmitterWithFixedConstFactory extends DartEmitter {
  @override
  StringSink visitConstructor(Constructor spec, String clazz,
      [StringSink output]) {
    output ??= StringBuffer();
    spec.docs.forEach(output.writeln);
    spec.annotations.forEach((a) => visitAnnotation(a, output));
    if (spec.external) {
      output.write('external ');
    }
    if (spec.constant) {
      output.write('const ');
    }
    if (spec.factory) {
      output.write('factory ');
    }
    output.write(clazz);
    if (spec.name != null) {
      output..write('.')..write(spec.name);
    }
    output.write('(');
    if (spec.requiredParameters.isNotEmpty) {
      var count = 0;
      for (final p in spec.requiredParameters) {
        count++;
        _visitParameter(p, output);
        if (spec.requiredParameters.length != count ||
            spec.optionalParameters.isNotEmpty) {
          output.write(', ');
        }
      }
    }
    if (spec.optionalParameters.isNotEmpty) {
      final named = spec.optionalParameters.any((p) => p.named);
      if (named) {
        output.write('{');
      } else {
        output.write('[');
      }
      var count = 0;
      for (final p in spec.optionalParameters) {
        count++;
        _visitParameter(p, output, optional: true, named: named);
        if (spec.optionalParameters.length != count) {
          output.write(', ');
        }
      }
      if (named) {
        output.write('}');
      } else {
        output.write(']');
      }
    }
    output.write(')');
    if (spec.initializers.isNotEmpty) {
      output.write(' : ');
      var count = 0;
      for (final initializer in spec.initializers) {
        count++;
        initializer.accept(this, output);
        if (count != spec.initializers.length) {
          output.write(', ');
        }
      }
    }
    if (spec.redirect != null) {
      output.write(' = ');
      spec.redirect.type.accept(this, output);
      output.write(';');
    } else if (spec.body != null) {
      if (_isLambdaConstructor(spec)) {
        output.write(' => ');
        spec.body.accept(this, output);
        output.write(';');
      } else {
        output.write(' { ');
        spec.body.accept(this, output);
        output.write(' }');
      }
    } else {
      output.write(';');
    }
    output.writeln();
    return output;
  }

  static bool _isLambdaConstructor(Constructor constructor) =>
      constructor.lambda ??
      constructor.factory && _isLambdaBody(constructor.body);

  static bool _isLambdaBody(Code code) =>
      code is ToCodeExpression && !code.isStatement;

  void _visitParameter(
    Parameter spec,
    StringSink output, {
    bool optional = false,
    bool named = false,
  }) {
    spec.docs.forEach(output.writeln);
    spec.annotations.forEach((a) => visitAnnotation(a, output));
    // The `required` keyword must precede the `covariant` keyword.
    if (spec.required) {
      output.write('required ');
    }
    if (spec.covariant) {
      output.write('covariant ');
    }
    if (spec.type != null) {
      spec.type.type.accept(this, output);
      output.write(' ');
    }
    if (spec.toThis) {
      output.write('this.');
    }
    output.write(spec.name);
    if (optional && spec.defaultTo != null) {
      output.write(' = ');
      spec.defaultTo.accept(this, output);
    }
  }
}
