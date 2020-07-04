import 'data_class.dart';

void main() {
  const dc1 = DataClass(field1: 7);
  final dc2 = dc1.copyWith(field1: 1);
  final dc3 = dc1.copyWith(field1: 1, field2: null);
  print(dc1); // DataClass(field1: 7, field2: default value)
  print(dc2); // DataClass(field1: 1, field2: default value)
  print(dc3); // DataClass(field1: 1, field2: default value)

  const dcwnf1 = DataClassWithNullableField(field1: 7);
  final dcwnf2 = dcwnf1.copyWith(field1: 1);
  final dcwnf3 = dcwnf1.copyWith(field1: 1, field2: null);
  print(dcwnf1); // DataClassWithNullableField(field1: 7, field2: default value)
  print(dcwnf2); // DataClassWithNullableField(field1: 1, field2: default value)
  print(dcwnf3); // DataClassWithNullableField(field1: 1, field2: null)

  // const pdc1 = _PrivateDataClass(7);
  // final pdc2 = pdc1._copyWith(field1: 1);

  // const dcwpc1 = DataClassWithPrivateConstructor._(7);
  // final dcwpc2 = dcwpc1._copyWith(field1: 1);

  final mdc1 = MutableDataClass(field1: 7);
  print(mdc1); // MutableDataClass(field1: 7, field2: null)
  mdc1.field2 = 'value';
  print(mdc1); // MutableDataClass(field1: 7, field2: value)
}
