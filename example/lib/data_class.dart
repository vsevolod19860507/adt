import 'package:adt_annotation/adt_annotation.dart';

part 'data_class.g.dart';

@data
class DataClass with _$DataClass {
  const DataClass({
    @required this.field1,
    this.field2 = 'default value',
  })  : assert(field1 != null),
        assert(field2 != null);

  final int field1;
  final String field2;
}

@data
class DataClassWithNullableField with _$DataClassWithNullableField {
  const DataClassWithNullableField({
    @required this.field1,
    @nullable this.field2 = 'default value',
  }) : assert(field1 != null);

  final int field1;
  final String field2;
}

@data
class GenericDataClass<T, S extends Iterable<T>> with _$GenericDataClass<T, S> {
  const GenericDataClass(this.field1, this.field2)
      : assert(field1 != null),
        assert(field2 != null);

  final T field1;
  final S field2;
}

@data
class _PrivateDataClass with _$_PrivateDataClass {
  const _PrivateDataClass(this.field1, [@nullable this.field2])
      : assert(field1 != null);

  final int field1;
  final String field2;
}

@data
class DataClassWithPrivateConstructor with _$DataClassWithPrivateConstructor {
  const DataClassWithPrivateConstructor._(this.field1, [@nullable this.field2])
      : assert(field1 != null);

  final int field1;
  final String field2;

  static MapEntry<DataClassWithPrivateConstructor, DateTime> create(
    int field1, [
    String field2,
  ]) {
    if (field1 < 0) {
      throw Exception();
    }
    return MapEntry(
        DataClassWithPrivateConstructor._(field1, field2), DateTime.now());
  }
}

@data
@mutable
class MutableDataClass with _$MutableDataClass {
  MutableDataClass({@required this.field1, @nullable this.field2})
      : assert(field1 != null);

  final int field1;
  String field2;
}

abstract class Interface {
  int get field1;
  String get field2;
  String get field3;
}

@data
class MultipleConstructorDataClass extends DataClass
    with _$MultipleConstructorDataClass
    implements Interface {
  MultipleConstructorDataClass(int field1) : this._(field1);

  @primary
  MultipleConstructorDataClass._(int field1)
      : field3 = 'default value',
        _creationDate = DateTime.now(),
        super(field1: field1);

  @override
  final String field3;
  final DateTime _creationDate;

  String showCreationDate() =>
      'year: ${_creationDate.year}, month: ${_creationDate.month} '
      'day: ${_creationDate.day}';
}
