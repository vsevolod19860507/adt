// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'union.dart';

// ignore_for_file: avoid_init_to_null, unnecessary_brace_in_string_interps, unnecessary_parenthesis, unused_element, lines_longer_than_80_chars, avoid_types_on_closure_parameters,

// **************************************************************************
// ADTGenerator
// **************************************************************************

// *****************************************************************************
// Union
// *****************************************************************************
extension $$Union on Union {
  ReturnType match<ReturnType>(
      {@required ReturnType Function() case1,
      @required ReturnType Function(int) case2,
      @required ReturnType Function(String) case3}) {
    assert(case1 != null);
    assert(case2 != null);
    assert(case3 != null);
    return (this as _$Union).match(case1: case1, case2: case2, case3: case3);
  }

  ReturnType matchOrDefault<ReturnType>(
      {ReturnType Function() case1,
      ReturnType Function(int) case2,
      ReturnType Function(String) case3,
      @required ReturnType Function() orDefault}) {
    assert(orDefault != null);
    return (this as _$Union).matchOrDefault(
        case1: case1, case2: case2, case3: case3, orDefault: orDefault);
  }
}

@immutable
abstract class _$Union implements Union {
  const factory _$Union.case1() = _$Union$case1;

  const factory _$Union.case2(int value) = _$Union$case2;

  const factory _$Union.case3(String value) = _$Union$case3;

  ReturnType match<ReturnType>(
      {@required ReturnType Function() case1,
      @required ReturnType Function(int) case2,
      @required ReturnType Function(String) case3});
  ReturnType matchOrDefault<ReturnType>(
      {ReturnType Function() case1,
      ReturnType Function(int) case2,
      ReturnType Function(String) case3,
      @required ReturnType Function() orDefault});
}

class _$Union$case1 implements _$Union {
  const _$Union$case1();

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function() case1,
          @required ReturnType Function(int) case2,
          @required ReturnType Function(String) case3}) =>
      case1();
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function() case1,
          ReturnType Function(int) case2,
          ReturnType Function(String) case3,
          @required ReturnType Function() orDefault}) =>
      case1 != null ? case1() : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Union$case1 && identical(runtimeType, other.runtimeType);
  @override
  int get hashCode => runtimeType.hashCode;
  @override
  String toString() => 'Union.case1()';
}

class _$Union$case2 implements _$Union {
  const _$Union$case2(this._value) : assert(_value != null);

  final int _value;

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function() case1,
          @required ReturnType Function(int) case2,
          @required ReturnType Function(String) case3}) =>
      case2(_value);
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function() case1,
          ReturnType Function(int) case2,
          ReturnType Function(String) case3,
          @required ReturnType Function() orDefault}) =>
      case2 != null ? case2(_value) : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Union$case2 &&
          identical(runtimeType, other.runtimeType) &&
          const DeepCollectionEquality().equals([_value], [other._value]);
  @override
  int get hashCode =>
      const DeepCollectionEquality().hash([runtimeType.hashCode, _value]);
  @override
  String toString() => 'Union.case2(${_value})';
}

class _$Union$case3 implements _$Union {
  const _$Union$case3(this._value) : assert(_value != null);

  final String _value;

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function() case1,
          @required ReturnType Function(int) case2,
          @required ReturnType Function(String) case3}) =>
      case3(_value);
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function() case1,
          ReturnType Function(int) case2,
          ReturnType Function(String) case3,
          @required ReturnType Function() orDefault}) =>
      case3 != null ? case3(_value) : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Union$case3 &&
          identical(runtimeType, other.runtimeType) &&
          const DeepCollectionEquality().equals([_value], [other._value]);
  @override
  int get hashCode =>
      const DeepCollectionEquality().hash([runtimeType.hashCode, _value]);
  @override
  String toString() => 'Union.case3(${_value})';
}

// *****************************************************************************
// UnionWithNullableValue
// *****************************************************************************
extension $$UnionWithNullableValue on UnionWithNullableValue {
  ReturnType match<ReturnType>(
      {@required ReturnType Function(int) case1,
      @required ReturnType Function(int) case2}) {
    assert(case1 != null);
    assert(case2 != null);
    return (this as _$UnionWithNullableValue).match(case1: case1, case2: case2);
  }

  ReturnType matchOrDefault<ReturnType>(
      {ReturnType Function(int) case1,
      ReturnType Function(int) case2,
      @required ReturnType Function() orDefault}) {
    assert(orDefault != null);
    return (this as _$UnionWithNullableValue)
        .matchOrDefault(case1: case1, case2: case2, orDefault: orDefault);
  }
}

@immutable
abstract class _$UnionWithNullableValue implements UnionWithNullableValue {
  const factory _$UnionWithNullableValue.case1([int value]) =
      _$UnionWithNullableValue$case1;

  const factory _$UnionWithNullableValue.case2(int value) =
      _$UnionWithNullableValue$case2;

  ReturnType match<ReturnType>(
      {@required ReturnType Function(int) case1,
      @required ReturnType Function(int) case2});
  ReturnType matchOrDefault<ReturnType>(
      {ReturnType Function(int) case1,
      ReturnType Function(int) case2,
      @required ReturnType Function() orDefault});
}

class _$UnionWithNullableValue$case1 implements _$UnionWithNullableValue {
  const _$UnionWithNullableValue$case1([this._value = null]);

  final int _value;

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function(int) case1,
          @required ReturnType Function(int) case2}) =>
      case1(_value);
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function(int) case1,
          ReturnType Function(int) case2,
          @required ReturnType Function() orDefault}) =>
      case1 != null ? case1(_value) : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$UnionWithNullableValue$case1 &&
          identical(runtimeType, other.runtimeType) &&
          const DeepCollectionEquality().equals([_value], [other._value]);
  @override
  int get hashCode =>
      const DeepCollectionEquality().hash([runtimeType.hashCode, _value]);
  @override
  String toString() => 'UnionWithNullableValue.case1(${_value})';
}

class _$UnionWithNullableValue$case2 implements _$UnionWithNullableValue {
  const _$UnionWithNullableValue$case2(this._value);

  final int _value;

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function(int) case1,
          @required ReturnType Function(int) case2}) =>
      case2(_value);
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function(int) case1,
          ReturnType Function(int) case2,
          @required ReturnType Function() orDefault}) =>
      case2 != null ? case2(_value) : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$UnionWithNullableValue$case2 &&
          identical(runtimeType, other.runtimeType) &&
          const DeepCollectionEquality().equals([_value], [other._value]);
  @override
  int get hashCode =>
      const DeepCollectionEquality().hash([runtimeType.hashCode, _value]);
  @override
  String toString() => 'UnionWithNullableValue.case2(${_value})';
}

// *****************************************************************************
// UnionWithDefaultValue
// *****************************************************************************
extension $$UnionWithDefaultValue on UnionWithDefaultValue {
  ReturnType match<ReturnType>(
      {@required ReturnType Function(int) case1,
      @required ReturnType Function(int) case2,
      @required ReturnType Function(int) case3}) {
    assert(case1 != null);
    assert(case2 != null);
    assert(case3 != null);
    return (this as _$UnionWithDefaultValue)
        .match(case1: case1, case2: case2, case3: case3);
  }

  ReturnType matchOrDefault<ReturnType>(
      {ReturnType Function(int) case1,
      ReturnType Function(int) case2,
      ReturnType Function(int) case3,
      @required ReturnType Function() orDefault}) {
    assert(orDefault != null);
    return (this as _$UnionWithDefaultValue).matchOrDefault(
        case1: case1, case2: case2, case3: case3, orDefault: orDefault);
  }
}

@immutable
abstract class _$UnionWithDefaultValue implements UnionWithDefaultValue {
  const factory _$UnionWithDefaultValue.case1([int value]) =
      _$UnionWithDefaultValue$case1;

  const factory _$UnionWithDefaultValue.case2([int value]) =
      _$UnionWithDefaultValue$case2;

  const factory _$UnionWithDefaultValue.case3([int value]) =
      _$UnionWithDefaultValue$case3;

  ReturnType match<ReturnType>(
      {@required ReturnType Function(int) case1,
      @required ReturnType Function(int) case2,
      @required ReturnType Function(int) case3});
  ReturnType matchOrDefault<ReturnType>(
      {ReturnType Function(int) case1,
      ReturnType Function(int) case2,
      ReturnType Function(int) case3,
      @required ReturnType Function() orDefault});
}

class _$UnionWithDefaultValue$case1 implements _$UnionWithDefaultValue {
  const _$UnionWithDefaultValue$case1([this._value = null]);

  final int _value;

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function(int) case1,
          @required ReturnType Function(int) case2,
          @required ReturnType Function(int) case3}) =>
      case1(_value);
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function(int) case1,
          ReturnType Function(int) case2,
          ReturnType Function(int) case3,
          @required ReturnType Function() orDefault}) =>
      case1 != null ? case1(_value) : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$UnionWithDefaultValue$case1 &&
          identical(runtimeType, other.runtimeType) &&
          const DeepCollectionEquality().equals([_value], [other._value]);
  @override
  int get hashCode =>
      const DeepCollectionEquality().hash([runtimeType.hashCode, _value]);
  @override
  String toString() => 'UnionWithDefaultValue.case1(${_value})';
}

class _$UnionWithDefaultValue$case2 implements _$UnionWithDefaultValue {
  const _$UnionWithDefaultValue$case2([this._value = 7])
      : assert(_value != null);

  final int _value;

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function(int) case1,
          @required ReturnType Function(int) case2,
          @required ReturnType Function(int) case3}) =>
      case2(_value);
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function(int) case1,
          ReturnType Function(int) case2,
          ReturnType Function(int) case3,
          @required ReturnType Function() orDefault}) =>
      case2 != null ? case2(_value) : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$UnionWithDefaultValue$case2 &&
          identical(runtimeType, other.runtimeType) &&
          const DeepCollectionEquality().equals([_value], [other._value]);
  @override
  int get hashCode =>
      const DeepCollectionEquality().hash([runtimeType.hashCode, _value]);
  @override
  String toString() => 'UnionWithDefaultValue.case2(${_value})';
}

class _$UnionWithDefaultValue$case3 implements _$UnionWithDefaultValue {
  const _$UnionWithDefaultValue$case3([this._value = 7]);

  final int _value;

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function(int) case1,
          @required ReturnType Function(int) case2,
          @required ReturnType Function(int) case3}) =>
      case3(_value);
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function(int) case1,
          ReturnType Function(int) case2,
          ReturnType Function(int) case3,
          @required ReturnType Function() orDefault}) =>
      case3 != null ? case3(_value) : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$UnionWithDefaultValue$case3 &&
          identical(runtimeType, other.runtimeType) &&
          const DeepCollectionEquality().equals([_value], [other._value]);
  @override
  int get hashCode =>
      const DeepCollectionEquality().hash([runtimeType.hashCode, _value]);
  @override
  String toString() => 'UnionWithDefaultValue.case3(${_value})';
}

// *****************************************************************************
// GenericUnion<T,S extends Iterable<T>>
// *****************************************************************************
extension $$GenericUnion<T, S extends Iterable<T>> on GenericUnion<T, S> {
  ReturnType match<ReturnType>(
      {@required ReturnType Function(T) case1,
      @required ReturnType Function(S) case2,
      @required ReturnType Function() case3}) {
    assert(case1 != null);
    assert(case2 != null);
    assert(case3 != null);
    return (this as _$GenericUnion<T, S>)
        .match(case1: case1, case2: case2, case3: case3);
  }

  ReturnType matchOrDefault<ReturnType>(
      {ReturnType Function(T) case1,
      ReturnType Function(S) case2,
      ReturnType Function() case3,
      @required ReturnType Function() orDefault}) {
    assert(orDefault != null);
    return (this as _$GenericUnion<T, S>).matchOrDefault(
        case1: case1, case2: case2, case3: case3, orDefault: orDefault);
  }
}

@immutable
abstract class _$GenericUnion<T, S extends Iterable<T>>
    implements GenericUnion<T, S> {
  const factory _$GenericUnion.case1(T value) = _$GenericUnion$case1<T, S>;

  const factory _$GenericUnion.case2(S value) = _$GenericUnion$case2<T, S>;

  const factory _$GenericUnion.case3() = _$GenericUnion$case3<T, S>;

  ReturnType match<ReturnType>(
      {@required ReturnType Function(T) case1,
      @required ReturnType Function(S) case2,
      @required ReturnType Function() case3});
  ReturnType matchOrDefault<ReturnType>(
      {ReturnType Function(T) case1,
      ReturnType Function(S) case2,
      ReturnType Function() case3,
      @required ReturnType Function() orDefault});
}

class _$GenericUnion$case1<T, S extends Iterable<T>>
    implements _$GenericUnion<T, S> {
  const _$GenericUnion$case1(this._value) : assert(_value != null);

  final T _value;

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function(T) case1,
          @required ReturnType Function(S) case2,
          @required ReturnType Function() case3}) =>
      case1(_value);
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function(T) case1,
          ReturnType Function(S) case2,
          ReturnType Function() case3,
          @required ReturnType Function() orDefault}) =>
      case1 != null ? case1(_value) : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$GenericUnion$case1<T, S> &&
          identical(runtimeType, other.runtimeType) &&
          const DeepCollectionEquality().equals([_value], [other._value]);
  @override
  int get hashCode =>
      const DeepCollectionEquality().hash([runtimeType.hashCode, _value]);
  @override
  String toString() => 'GenericUnion<${T}, ${S}>.case1(${_value})';
}

class _$GenericUnion$case2<T, S extends Iterable<T>>
    implements _$GenericUnion<T, S> {
  const _$GenericUnion$case2(this._value) : assert(_value != null);

  final S _value;

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function(T) case1,
          @required ReturnType Function(S) case2,
          @required ReturnType Function() case3}) =>
      case2(_value);
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function(T) case1,
          ReturnType Function(S) case2,
          ReturnType Function() case3,
          @required ReturnType Function() orDefault}) =>
      case2 != null ? case2(_value) : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$GenericUnion$case2<T, S> &&
          identical(runtimeType, other.runtimeType) &&
          const DeepCollectionEquality().equals([_value], [other._value]);
  @override
  int get hashCode =>
      const DeepCollectionEquality().hash([runtimeType.hashCode, _value]);
  @override
  String toString() => 'GenericUnion<${T}, ${S}>.case2(${_value})';
}

class _$GenericUnion$case3<T, S extends Iterable<T>>
    implements _$GenericUnion<T, S> {
  const _$GenericUnion$case3();

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function(T) case1,
          @required ReturnType Function(S) case2,
          @required ReturnType Function() case3}) =>
      case3();
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function(T) case1,
          ReturnType Function(S) case2,
          ReturnType Function() case3,
          @required ReturnType Function() orDefault}) =>
      case3 != null ? case3() : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$GenericUnion$case3<T, S> &&
          identical(runtimeType, other.runtimeType);
  @override
  int get hashCode => runtimeType.hashCode;
  @override
  String toString() => 'GenericUnion<${T}, ${S}>.case3()';
}

// *****************************************************************************
// _PrivateUnion
// *****************************************************************************
extension $$_PrivateUnion on _PrivateUnion {
  ReturnType match<ReturnType>(
      {@required ReturnType Function() value1,
      @required ReturnType Function(int) value2}) {
    assert(value1 != null);
    assert(value2 != null);
    return (this as _$_PrivateUnion).match(value1: value1, value2: value2);
  }

  ReturnType matchOrDefault<ReturnType>(
      {ReturnType Function() value1,
      ReturnType Function(int) value2,
      @required ReturnType Function() orDefault}) {
    assert(orDefault != null);
    return (this as _$_PrivateUnion)
        .matchOrDefault(value1: value1, value2: value2, orDefault: orDefault);
  }
}

@immutable
abstract class _$_PrivateUnion implements _PrivateUnion {
  const factory _$_PrivateUnion.value1() = _$_PrivateUnion$value1;

  const factory _$_PrivateUnion.value2(int value) = _$_PrivateUnion$value2;

  ReturnType match<ReturnType>(
      {@required ReturnType Function() value1,
      @required ReturnType Function(int) value2});
  ReturnType matchOrDefault<ReturnType>(
      {ReturnType Function() value1,
      ReturnType Function(int) value2,
      @required ReturnType Function() orDefault});
}

class _$_PrivateUnion$value1 implements _$_PrivateUnion {
  const _$_PrivateUnion$value1();

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function() value1,
          @required ReturnType Function(int) value2}) =>
      value1();
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function() value1,
          ReturnType Function(int) value2,
          @required ReturnType Function() orDefault}) =>
      value1 != null ? value1() : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$_PrivateUnion$value1 &&
          identical(runtimeType, other.runtimeType);
  @override
  int get hashCode => runtimeType.hashCode;
  @override
  String toString() => '_PrivateUnion.value1()';
}

class _$_PrivateUnion$value2 implements _$_PrivateUnion {
  const _$_PrivateUnion$value2(this._value) : assert(_value != null);

  final int _value;

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function() value1,
          @required ReturnType Function(int) value2}) =>
      value2(_value);
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function() value1,
          ReturnType Function(int) value2,
          @required ReturnType Function() orDefault}) =>
      value2 != null ? value2(_value) : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$_PrivateUnion$value2 &&
          identical(runtimeType, other.runtimeType) &&
          const DeepCollectionEquality().equals([_value], [other._value]);
  @override
  int get hashCode =>
      const DeepCollectionEquality().hash([runtimeType.hashCode, _value]);
  @override
  String toString() => '_PrivateUnion.value2(${_value})';
}

// *****************************************************************************
// UnionWithAdditionalMembers
// *****************************************************************************
extension $$UnionWithAdditionalMembers on UnionWithAdditionalMembers {
  ReturnType match<ReturnType>(
      {@required ReturnType Function() case1,
      @required ReturnType Function(int) case2,
      @required ReturnType Function(String) case3}) {
    assert(case1 != null);
    assert(case2 != null);
    assert(case3 != null);
    return (this as _$UnionWithAdditionalMembers)
        .match(case1: case1, case2: case2, case3: case3);
  }

  ReturnType matchOrDefault<ReturnType>(
      {ReturnType Function() case1,
      ReturnType Function(int) case2,
      ReturnType Function(String) case3,
      @required ReturnType Function() orDefault}) {
    assert(orDefault != null);
    return (this as _$UnionWithAdditionalMembers).matchOrDefault(
        case1: case1, case2: case2, case3: case3, orDefault: orDefault);
  }
}

@immutable
abstract class _$UnionWithAdditionalMembers extends UnionWithAdditionalMembers {
  const _$UnionWithAdditionalMembers() : super._();

  const factory _$UnionWithAdditionalMembers.case1() =
      _$UnionWithAdditionalMembers$case1;

  const factory _$UnionWithAdditionalMembers.case2(int value) =
      _$UnionWithAdditionalMembers$case2;

  const factory _$UnionWithAdditionalMembers.case3(String value) =
      _$UnionWithAdditionalMembers$case3;

  ReturnType match<ReturnType>(
      {@required ReturnType Function() case1,
      @required ReturnType Function(int) case2,
      @required ReturnType Function(String) case3});
  ReturnType matchOrDefault<ReturnType>(
      {ReturnType Function() case1,
      ReturnType Function(int) case2,
      ReturnType Function(String) case3,
      @required ReturnType Function() orDefault});
}

class _$UnionWithAdditionalMembers$case1 extends _$UnionWithAdditionalMembers {
  const _$UnionWithAdditionalMembers$case1();

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function() case1,
          @required ReturnType Function(int) case2,
          @required ReturnType Function(String) case3}) =>
      case1();
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function() case1,
          ReturnType Function(int) case2,
          ReturnType Function(String) case3,
          @required ReturnType Function() orDefault}) =>
      case1 != null ? case1() : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$UnionWithAdditionalMembers$case1 &&
          identical(runtimeType, other.runtimeType);
  @override
  int get hashCode => runtimeType.hashCode;
  @override
  String toString() => 'UnionWithAdditionalMembers.case1()';
}

class _$UnionWithAdditionalMembers$case2 extends _$UnionWithAdditionalMembers {
  const _$UnionWithAdditionalMembers$case2(this._value)
      : assert(_value != null);

  final int _value;

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function() case1,
          @required ReturnType Function(int) case2,
          @required ReturnType Function(String) case3}) =>
      case2(_value);
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function() case1,
          ReturnType Function(int) case2,
          ReturnType Function(String) case3,
          @required ReturnType Function() orDefault}) =>
      case2 != null ? case2(_value) : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$UnionWithAdditionalMembers$case2 &&
          identical(runtimeType, other.runtimeType) &&
          const DeepCollectionEquality().equals([_value], [other._value]);
  @override
  int get hashCode =>
      const DeepCollectionEquality().hash([runtimeType.hashCode, _value]);
  @override
  String toString() => 'UnionWithAdditionalMembers.case2(${_value})';
}

class _$UnionWithAdditionalMembers$case3 extends _$UnionWithAdditionalMembers {
  const _$UnionWithAdditionalMembers$case3(this._value)
      : assert(_value != null);

  final String _value;

  @override
  ReturnType match<ReturnType>(
          {@required ReturnType Function() case1,
          @required ReturnType Function(int) case2,
          @required ReturnType Function(String) case3}) =>
      case3(_value);
  @override
  ReturnType matchOrDefault<ReturnType>(
          {ReturnType Function() case1,
          ReturnType Function(int) case2,
          ReturnType Function(String) case3,
          @required ReturnType Function() orDefault}) =>
      case3 != null ? case3(_value) : orDefault();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$UnionWithAdditionalMembers$case3 &&
          identical(runtimeType, other.runtimeType) &&
          const DeepCollectionEquality().equals([_value], [other._value]);
  @override
  int get hashCode =>
      const DeepCollectionEquality().hash([runtimeType.hashCode, _value]);
  @override
  String toString() => 'UnionWithAdditionalMembers.case3(${_value})';
}
