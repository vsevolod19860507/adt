import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';

import 'adt_generator.dart';

Builder adtGeneratorBuilder(BuilderOptions options) => SharedPartBuilder(
      [ADTGenerator()],
      'generator_app',
      formatOutput: (output) => DartFormatter().format(ignoreForFile + output),
    );

const ignoreForFile = '// ignore_for_file: '
    'unnecessary_brace_in_string_interps, '
    'unnecessary_parenthesis, '
    'unused_element, '
    '\n\n';
