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
class _PrivateDataClass with _$_PrivateDataClass {
  final int field1;
  final String field2;

  const _PrivateDataClass(
    this.field1, [
    @nullable this.field2,
  ]) : assert(field1 != null);
}

@data
class DataClassWithPrivateConstructor with _$DataClassWithPrivateConstructor {
  final int field1;
  final String field2;

  const DataClassWithPrivateConstructor._(
    this.field1, [
    @nullable this.field2,
  ]) : assert(field1 != null);
}

@data
@mutable
class MutableDataClass with _$MutableDataClass {
  final int field1;
  String field2;

  MutableDataClass({
    @required this.field1,
    @nullable this.field2,
  }) : assert(field1 != null);
}
