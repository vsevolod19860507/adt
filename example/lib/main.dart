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

  const gdc1 = GenericDataClass(7, {7});
  const gdc2 = GenericDataClass('A', ['A']);
  print(gdc1); // GenericDataClass<int, Set<int>>(field1: 7, field2: {7})
  print(gdc2); // GenericDataClass<String, List<String>>(field1: A, field2: [A])

  // const pdc1 = _PrivateDataClass(7);
  // final pdc2 = pdc1._copyWith(field1: 1);

  // const dcwpc1 = DataClassWithPrivateConstructor._(7);
  // final dcwpc2 = dcwpc1._copyWith(field1: 1);
  final result = DataClassWithPrivateConstructor.create(7, 'A');
  final dcwpc3 = result.keys.first;
  final date = result.values.first;
  print(dcwpc3); // DataClassWithPrivateConstructor(field1: 7, field2: A)
  print(date); // 2020-07-04 21:06:46.902073

  final mdc1 = MutableDataClass(field1: 7);
  print(mdc1); // MutableDataClass(field1: 7, field2: null)
  mdc1.field2 = 'value';
  print(mdc1); // MutableDataClass(field1: 7, field2: value)

  final mcdc1 = MultipleConstructorDataClass(7);
  print(mcdc1); // MultipleConstructorDataClass(field1: 7)
  print(mcdc1.showCreationDate()); // year: 2020, month: 7 day: 4
}
