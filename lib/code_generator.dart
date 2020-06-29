import 'package:adt_annotation/adt_annotation.dart';
import 'package:meta/meta.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

import 'code_generator_data.dart';
import 'code_generator_union.dart';

@immutable
class ADTGenerator extends GeneratorForAnnotation<ADT> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final typeOfGneratedContent = element.metadata
        .map((m) => m.element.name)
        .firstWhere((n) => n == 'data' || n == 'union', orElse: () => '');

    if (typeOfGneratedContent == 'data') {
      return ignoreForFile + generateDataClass(element);
    }

    if (typeOfGneratedContent == 'union') {
      return ignoreForFile + generateUnionClass(element);
    }

    return null;
  }
}

const ignoreForFile = '// ignore_for_file: '
    'unnecessary_brace_in_string_interps,'
    'unnecessary_parenthesis,'
    'unused_element,'
    '\n';
