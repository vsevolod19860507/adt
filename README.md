# Algebraic data types

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
See [build_runner](https://pub.dev/packages/build_runner) for more details.


**Now there is a [bug](https://github.com/dart-lang/sdk/issues/42218) in the analyzer, to fix it, add the following to your [`analysis_options.yaml`](https://dart.dev/guides/language/analysis-options).**

```yaml
analyzer:
  errors:
    const_constructor_with_mixin_with_field: ignore
```

## Data class
The data class overrides `==`, `hashCode`, `toString`. It also creates a `copyWith` method. The fields that will be used in them must be described as constructor parameters, these can be any type of parameters. Constructor must contain at least one parameter.

To create a data class, use the `@data` annotation, this will create an immutable data class.

```dart
@data
class User with _$User {
  final String name;
  final int age;

  const User({@required this.name, @required this.age})
      : assert(name != null),
        assert(age != null);
}
```

A `copyWith` method allows you to create a copy of an object with the ability to change fields values.

```dart
const user1 = User('Vsevolod', 34); // name: 'Vsevolod', age: 34
final user2 = user1.copyWith(name: 'Other Name'); // name: 'Other Name', age: 34
```

If you need mutable fields, add the `@mutable` annotation.

```dart
@data
@mutable
class User with _$User {
  final String name;
  int age;

  User({@required this.name, @required this.age})
      : assert(name != null),
        assert(age != null);
}
```

If you need a nullable field, add the `@nullable` annotation to the parameter. This is necessary for a `copyWith` method to work properly in order to be able to set the value of a nullable field to null.

```dart
@data
class User with _$User {
  final String name;
  final int age;

  const User({@required this.name, @nullable this.age}) : assert(name != null);
}
```

<!-- You can use more than one constructor, but in this case one of them must have the `@primary` annotation. -->




_Description will be soon..._
