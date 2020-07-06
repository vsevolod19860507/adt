import 'package:adt_annotation/adt_annotation.dart';

part 'union.g.dart';

@union
class Union {
  const factory Union.case1() = _$Union.case1;
  const factory Union.case2(int value) = _$Union.case2;
  const factory Union.case3(String value) = _$Union.case3;
}

@union
class UnionWithNullableValue {
  const factory UnionWithNullableValue.case1([@nullable int value]) =
      _$UnionWithNullableValue.case1;
  const factory UnionWithNullableValue.case2(@nullable int value) =
      _$UnionWithNullableValue.case2;
}

@union
class UnionWithDefaultValue {
  const factory UnionWithDefaultValue.case1([@nullable int value]) =
      _$UnionWithDefaultValue.case1;
  const factory UnionWithDefaultValue.case2([@Default(7) int value]) =
      _$UnionWithDefaultValue.case2;
  const factory UnionWithDefaultValue.case3([@Default(7) @nullable int value]) =
      _$UnionWithDefaultValue.case3;
}

@union
class GenericUnion<T, S extends Iterable<T>> {
  const factory GenericUnion.case1(T value) = _$GenericUnion<T, S>.case1;
  const factory GenericUnion.case2(S value) = _$GenericUnion<T, S>.case2;
  const factory GenericUnion.case3() = _$GenericUnion<T, S>.case3;
}

@union
class _PrivateUnion {
  const factory _PrivateUnion.value1() = _$_PrivateUnion.value1;
  const factory _PrivateUnion.value2(int value) = _$_PrivateUnion.value2;
}

@union
class UnionWithAdditionalMembers {
  const UnionWithAdditionalMembers._()
      : field1 = 7,
        _field2 = 7;
  const factory UnionWithAdditionalMembers.case1() =
      _$UnionWithAdditionalMembers.case1;
  const factory UnionWithAdditionalMembers.case2(int value) =
      _$UnionWithAdditionalMembers.case2;
  const factory UnionWithAdditionalMembers.case3(String value) =
      _$UnionWithAdditionalMembers.case3;

  final int field1;
  final int _field2;
  int meth() => field1 + _field2;
}
