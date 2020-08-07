import 'data_class.dart';
import 'union.dart';

void main() {
  // ***************************************************************************
  // Data classes
  // ***************************************************************************
  const dc1 = DataClass(field1: 7);
  final dc2 = dc1.copyWith(field1: 1);
  final dc3 = dc1.copyWith(field1: 1);
  print(dc1.hashCode); // 1286781335
  print(dc2.hashCode); // 119482181
  print(dc3.hashCode); // 119482181
  print(dc1 == dc2); // false
  print(dc1 == dc3); // false
  print(dc2 == dc2); // true
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
  final dcwpc3 = DataClassWithPrivateConstructor.create(7, 'A');
  print(dcwpc3.key); // DataClassWithPrivateConstructor(field1: 7, field2: A)
  print(dcwpc3.value); // 2020-07-04 21:06:46.902073

  final mdc1 = MutableDataClass(field1: 7);
  print(mdc1); // MutableDataClass(field1: 7, field2: null)
  mdc1.field2 = 'value';
  print(mdc1); // MutableDataClass(field1: 7, field2: value)

  final mcdc1 = MultipleConstructorDataClass(7);
  print(mcdc1); // MultipleConstructorDataClass(field1: 7)
  print(mcdc1.showCreationDate()); // year: 2020, month: 7 day: 4

  // ***************************************************************************
  // Unions
  // ***************************************************************************
  const u1 = Union.case1();
  const u2 = Union.case2(7);
  const u3 = Union.case3('A');
  const u4 = Union.case1();
  const u5 = Union.case3('A');
  print(u1.hashCode); // 9793584
  print(u2.hashCode); // 1471274145
  print(u3.hashCode); // 878724698
  print(u4.hashCode); // 9793584
  print(u5.hashCode); // 878724698
  print(u1 == u2); // false
  print(u2 == u3); // false
  print(u1 == u4); // true
  print(u3 == u5); // true
  print(u1); // Union.case1()
  print(u2); // Union.case2(7)
  print(u3); // Union.case3(A)
  final u1m = u1.match(
    case1: () => 'case1()',
    case2: (x) => 'case2($x)',
    case3: (x) => 'case3($x)',
  );
  final u2m = u2.match(
    case1: () => 'case1()',
    case2: (x) => 'case2($x)',
    case3: (x) => 'case3($x)',
  );
  final u3m = u3.match(
    case1: () => 'case1()',
    case2: (x) => 'case2($x)',
    case3: (x) => 'case3($x)',
  );
  print(u1m); // case1()
  print(u2m); // case2(7)
  print(u3m); // case2(A)
  final u1mod = u1.matchOrDefault(
    case2: (x) => 'case2($x)',
    orDefault: () => 'orDefault',
  );
  final u2mod = u2.matchOrDefault(
    case2: (x) => 'case2($x)',
    orDefault: () => 'orDefault',
  );
  final u3mod = u3.matchOrDefault(
    case2: (x) => 'case2($x)',
    orDefault: () => 'orDefault',
  );
  print(u1mod); // orDefault
  print(u2mod); // case2(7)
  print(u3mod); // orDefault

  const uwnv1 = UnionWithNullableValue.case1();
  const uwnv2 = UnionWithNullableValue.case2(null);
  print(uwnv1); // UnionWithNullableValue.case1(null)
  print(uwnv2); // UnionWithNullableValue.case2(null)

  const uwdv1 = UnionWithDefaultValue.case1();
  const uwdv2 = UnionWithDefaultValue.case2();
  const uwdv3 = UnionWithDefaultValue.case3(null);
  const uwdv4 = UnionWithDefaultValue.case3();
  const uwdv5 = UnionWithDefaultValue.case3(3);
  print(uwdv1); // UnionWithDefaultValue.case1(null)
  print(uwdv2); // UnionWithDefaultValue.case2(7)
  print(uwdv3); // UnionWithDefaultValue.case3(null)
  print(uwdv4); // UnionWithDefaultValue.case3(7)
  print(uwdv5); // UnionWithDefaultValue.case3(3)

  const gu1 = GenericUnion.case1(1);
  const gu2 = GenericUnion<int, List<int>>.case2([1]);
  const gu3 = GenericUnion<int, List<int>>.case3();
  print(gu1); // GenericUnion<int, Iterable<int>>.case1(1)
  print(gu2); // GenericUnion<int, List<int>>.case2([1])
  print(gu3); // GenericUnion<int, List<int>>.case3()

  // const pu1 = _PrivateUnion.case1();
  // const pu2 = _PrivateUnion.case2(7);

  const uwam1 = UnionWithAdditionalMembers.case1();
  print(uwam1.field1); // 7
  print(uwam1.meth()); // 14
}
