import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

import 'code_generator.dart';

Builder adtGeneratorBuilder(BuilderOptions options) =>
    SharedPartBuilder([ADTGenerator()], 'generator_app');
