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

@data
class User with _$User {
  final String name;
  final int age;

  const User(this.name, this.age)
      : assert(name != null),
        assert(age != null);
}

@union
class Status {
  const factory Status.normal() = _$Status.normal;
  const factory Status.vip(String id) = _$Status.vip;
}
```

Finally, run the generator by writing at the command prompt `flutter pub run build_runner build` for Flutter project, or `pub run build_runner build` for other projects.
See [here](https://pub.dev/packages/build_runner) for more details.


**Now there is a [bug](https://github.com/dart-lang/sdk/issues/42218) in the analyzer, to fix it, add the following to your [`analysis_options.yaml`](https://dart.dev/guides/language/analysis-options).**

```yaml
analyzer:
  errors:
    const_constructor_with_mixin_with_field: ignore
```



_Description will be soon..._
