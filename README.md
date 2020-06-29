# adt

A code generator for algebraic data types such as data classes and discriminated unions.

## Getting Started

You should install three packages as dependencies:

- [adt_annotation](https://pub.dev/packages/adt_annotation)
- adt
- [build_runner](https://pub.dev/packages/build_runner)

```yaml
dependencies:
  adt_annotation: ^0.0.1

dev_dependencies:
  adt: ^0.0.1
  build_runner: ^1.10.0
```

Then, in the file for which you want to generate the code, add the following:

```dart
import 'package:adt_annotation/adt_annotation.dart';

part 'your_file_name.g.dart';
```


Description will be soon
