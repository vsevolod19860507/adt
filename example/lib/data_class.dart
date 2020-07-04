import 'package:adt_annotation/adt_annotation.dart';

part 'data_class.g.dart';

@data
class DataClass with _$DataClass {
  final int field1;
  final String field2;

  const DataClass({
    @required this.field1,
    this.field2 = 'default value',
  })  : assert(field1 != null),
        assert(field2 != null);
}

@data
class DataClassWithNullableField with _$DataClassWithNullableField {
  final int field1;
  final String field2;

  const DataClassWithNullableField({
    @required this.field1,
    @nullable this.field2 = 'default value',
  }) : assert(field1 != null);
}

@data
class GenericDataClass<T, S extends Iterable<T>> with _$GenericDataClass<T, S> {
  final T field1;
  final S field2;

  const GenericDataClass(this.field1, this.field2)
      : assert(field1 != null),
        assert(field2 != null);
}

@data
class _PrivateDataClass with _$_PrivateDataClass {
  final int field1;
  final String field2;

  const _PrivateDataClass(this.field1, [@nullable this.field2])
      : assert(field1 != null);
}

@data
class DataClassWithPrivateConstructor with _$DataClassWithPrivateConstructor {
  final int field1;
  final String field2;

  const DataClassWithPrivateConstructor._(this.field1, [@nullable this.field2])
      : assert(field1 != null);

  static Map<DataClassWithPrivateConstructor, DateTime> create(
    int field1, [
    String field2,
  ]) {
    if (field1 < 0) {
      throw Exception();
    }
    return {DataClassWithPrivateConstructor._(field1, field2): DateTime.now()};
  }
}

@data
@mutable
class MutableDataClass with _$MutableDataClass {
  final int field1;
  String field2;

  MutableDataClass({@required this.field1, @nullable this.field2})
      : assert(field1 != null);
}

abstract class Interface {
  int get field1;
  String get field2;
  String get field3;
  DateTime get _creationDate;

  String showCreationDate();
}

@data
class MultipleConstructorDataClass extends DataClass
    with _$MultipleConstructorDataClass
    implements Interface {
  @override
  final String field3;
  @override
  final DateTime _creationDate;

  MultipleConstructorDataClass(int field1) : this._(field1);

  @primary
  MultipleConstructorDataClass._(int field1)
      : field3 = 'default value',
        _creationDate = DateTime.now(),
        super(field1: field1);

  @override
  String showCreationDate() =>
      'year: ${_creationDate.year}, month: ${_creationDate.month} day: ${_creationDate.day}';
}
