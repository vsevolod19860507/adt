import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

import 'code_generator.dart';

Builder codeGeneratorBuilder(BuilderOptions options) =>
    SharedPartBuilder([CodeGenerator()], 'generator_app');
