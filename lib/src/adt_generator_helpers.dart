import 'package:meta/meta.dart';
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
