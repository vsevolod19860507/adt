# Algebraic data types: data classes and discriminated unions

A code generator for algebraic data types such as immutable data classes with `copyWith` method and immutable discriminated unions with pattern matching. They compare as value types.

If you need immutable collections, you can use [immutable_collection](https://pub.dev/packages/immutable_collection).

- [Data class](#data-class)
- [Union](#union)

## Getting Started

You should install three packages as dependencies:

- [adt_annotation](https://pub.dev/packages/adt_annotation)
- adt
- [build_runner](https://pub.dev/packages/build_runner)

```yaml
dependencies:
  adt_annotation: ^0.3.0

dev_dependencies:
  build_runner: ^1.0.0
  adt: ^0.5.0
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

## Data class
The data class сontains fields that are used in `==`, `hashCode`, `toString`, `copyWith` which it creates for you. `==` and `hashCode` allow to compare objects as values, `toString` gives you a string representation of this object, `copyWith` method allows you to create a copy of an object with the ability to change fields values. You can always manually override them if you want. 

To create an immutable data class, use the `@data` annotation on `DataClassName with _$DataClassName` and add a constructor with some parameters, which  if you need a private data class use the following `_DataClassName with _$_DataClassName`. If a data class or constructor is private, then the `_copyWith` will also be private. To use more than one constructor, add `@primary` to one of them, and its parameters will be used to generate the data class.

You can place the fields corresponding to the constructor parameters either in the data class itself, or inherit them from somewhere. But in any case, the constructor parameters must have the same names as the corresponding fields, these parameters and fields must be public, and only they will be used inside `==`, `hashCode`, `toString`, `copyWith`. The constructor must contain at least one parameter. Add `@nullable` annotation to make a field nullable. This also is necessary for a `copyWith` method to work properly in order to be able to set the value of a nullable field to null. If you need to use mutable fields or your data class inherits another class that contains mutable fields than add the `@mutable` annotation. This will remove the `@immutable` annotation from the created mixin `_$DataClassName`.

You can freely apply generics to your `DataClassName<T> with _$DataClassName<T>` and also add any other members to a data class, such as other fields, methods, etc. You can also inherit, implement, and use mixins.

[Data class example](https://github.com/vr19860507/adt/blob/master/example/lib/data_class.dart)

## Union
The discriminated union is a class that can be in one of several possible states, each state can contain data. It creates `==`, `hashCode`, `toString`, `match`, `matchOrDefault`. `==` and `hashCode` allow to compare states of a union as values, `toString` gives you a string representation of current state, Pattern matching (`match` and `matchOrDefault`) is something like switch but more powerful and guarantees that all cases will be handled.

To create a union, use the `@union` annotation on `UnionName` and add some public named factory constructors with zero or one positional parameter. every factory constructor must redirect `const factory UnionName.case1(String value) = _$UnionName.case1;`. For private unions `_UnionName` use next `const factory _UnionName.case1(String value) = _$_UnionName.case1;`. Also you can apply generics to your `UnionName<T>` with such constructor `const factory UnionName.case1(String value) = _$UnionName<T>.case1;`.

You can use `@nullable` and `@Default()` annotations, to allows null `const factory UnionName.case1(@nullable int value) = _$UnionName.case1;` or add a default value `const factory UnionName.case1([@Default(7) int value]) = _$UnionName.case1;`.

If you want use some custom fields or methods, you have to add const private constructor to your union `const UnionName._()`

[Union example](https://github.com/vr19860507/adt/blob/master/example/lib/union.dart)