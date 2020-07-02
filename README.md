# Algebraic data types

A code generator for algebraic data types such as data classes and discriminated unions.

## Getting Started

You should install three packages as dependencies:

- [adt_annotation](https://pub.dev/packages/adt_annotation)
- adt
- [build_runner](https://pub.dev/packages/build_runner)

```yaml
dependencies:
  adt_annotation: ^0.1.0

dev_dependencies:
  adt: ^0.1.0
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
The data class сontains fields that are used in `==`, `hashCode`, `toString`, `copyWith` which it creates for you. (You can always manually override them if you want). To create an immutable data class, use the `@data` annotation on `DataClassName with _$DataClassName` and add a constructor with some parameters. You can place the corresponding fields either in the data class itself, or inherit them from somewhere. But in any case, the constructor parameters must have the same names as the corresponding fields, these parameters and fields must be public. The constructor must contain at least one parameter.

```dart
@data
class User1 with _$User1 {
  final String name;
  final int age;

  const User1({@required this.name, @required this.age})
      : assert(name != null),
        assert(age != null);
}

@data
class _User2 with _$_User2 {
  final String name;
  final int age;

  const _User2({@required this.name, @required this.age})
      : assert(name != null),
        assert(age != null);
}
```

A `copyWith` method allows you to create a copy of an object with the ability to change fields values. If the data class or constructor is private, then the `_copyWith` will also be private.

```dart
const user1 = User1('Vsevolod', 34); // name: 'Vsevolod', age: 34
final otherUser1 = user1.copyWith(name: 'Other Name'); // name: 'Other Name', age: 34

const user2 = _User2('Vsevolod', 34); // name: 'Vsevolod', age: 34
final otherUser2 = user2._copyWith(name: 'Other Name'); // name: 'Other Name', age: 34
```

If you need mutable fields, add the `@mutable` annotation. This will remove the `@immutable` annotation from the created mixin.

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

If you need a nullable field, add the `@nullable` annotation to the parameter. This also is necessary for a `copyWith` method to work properly in order to be able to set the value of a nullable field to null.

```dart
@data
class User with _$User {
  final String name;
  final int age;

  const User({@required this.name, @nullable this.age}) : assert(name != null);
}
```

You can use more than one constructor, but in this case one of them must have the `@primary` annotation. And its parameters will be used to generate the data class.

```dart
@data
class User with _$User {
  final String name;
  final int age;

  const User(String name) : this.withAge(name);

  @primary
  const User.withAge(this.name, [@nullable this.age = 34])
      : assert(name != null);
}
```

You can freely apply generics to your `DataClassName<T> with _$DataClassName<T>` and also add any other members to a data class, such as fields, methods, etc.

```dart
abstract class Data {
  int get value;
}

@data
class Address with _$Address {
  final String country;
  final String city;
  final String addressLine1;
  final String addressLine2;
  final String addressLine3;

  const Address(
    this.country,
    this.city,
    this.addressLine1, [
    @nullable this.addressLine2,
    @nullable this.addressLine3,
  ])  : assert(country != null),
        assert(city != null),
        assert(addressLine1 != null);
}

@data
@mutable
class _UserBase with _$_UserBase {
  final String name;
  final int age;

  const _UserBase(this.name, this.age)
      : assert(name != null),
        assert(age != null);
}

@data
@mutable
class User<T extends num, S extends Data> extends _UserBase with _$User<T, S> {
  Address address;
  T weigh;
  final S someField;

  S otherField1;
  S otherField2;

  User({
    @required String name,
    @required int age,
    @nullable this.address,
    @nullable this.weigh,
    @required this.someField,
  })  : assert(someField != null),
        super(name, age);

  void someMethod() {}
}
```

_Description will be soon..._
