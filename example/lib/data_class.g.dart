// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_class.dart';

// ignore_for_file: avoid_init_to_null, unnecessary_brace_in_string_interps, unnecessary_parenthesis, unused_element,

// **************************************************************************
// ADTGenerator
// **************************************************************************

// *****************************************************************************
// DataClass
// *****************************************************************************
@immutable
mixin _$DataClass {
  DataClass get _this => (this as DataClass);
  @override
  bool operator ==(Object other) {
    final $this = _this;
    return identical(this, other) ||
        identical($this.runtimeType, other.runtimeType) &&
            other is DataClass &&
            const DeepCollectionEquality().equals(
                [$this.field1, $this.field2], [other.field1, other.field2]);
  }

  @override
  int get hashCode {
    final $this = _this;
    return const DeepCollectionEquality()
        .hash([$this.runtimeType.hashCode, $this.field1, $this.field2]);
  }

  @override
  String toString() {
    final $this = _this;
    return 'DataClass(field1: ${$this.field1}, field2: ${$this.field2})';
  }
}

extension $$DataClass on DataClass {
  DataClass copyWith({int field1, String field2}) =>
      DataClass(field1: field1 ?? this.field1, field2: field2 ?? this.field2);
}

// *****************************************************************************
// DataClassWithNullableField
// *****************************************************************************
@immutable
mixin _$DataClassWithNullableField {
  DataClassWithNullableField get _this => (this as DataClassWithNullableField);
  @override
  bool operator ==(Object other) {
    final $this = _this;
    return identical(this, other) ||
        identical($this.runtimeType, other.runtimeType) &&
            other is DataClassWithNullableField &&
            const DeepCollectionEquality().equals(
                [$this.field1, $this.field2], [other.field1, other.field2]);
  }

  @override
  int get hashCode {
    final $this = _this;
    return const DeepCollectionEquality()
        .hash([$this.runtimeType.hashCode, $this.field1, $this.field2]);
  }

  @override
  String toString() {
    final $this = _this;
    return 'DataClassWithNullableField(field1: ${$this.field1}, field2: ${$this.field2})';
  }
}

extension $$DataClassWithNullableField on DataClassWithNullableField {
  DataClassWithNullableField Function({int field1, String field2})
      get copyWith =>
          ({field1, Object field2 = unused}) => DataClassWithNullableField(
              field1: field1 ?? this.field1,
              field2: field2 == unused ? this.field2 : (field2 as String));
}

// *****************************************************************************
// GenericDataClass<T,S extends Iterable<T>>
// *****************************************************************************
@immutable
mixin _$GenericDataClass<T, S extends Iterable<T>> {
  GenericDataClass<T, S> get _this => (this as GenericDataClass<T, S>);
  @override
  bool operator ==(Object other) {
    final $this = _this;
    return identical(this, other) ||
        identical($this.runtimeType, other.runtimeType) &&
            other is GenericDataClass<T, S> &&
            const DeepCollectionEquality().equals(
                [$this.field1, $this.field2], [other.field1, other.field2]);
  }

  @override
  int get hashCode {
    final $this = _this;
    return const DeepCollectionEquality()
        .hash([$this.runtimeType.hashCode, $this.field1, $this.field2]);
  }

  @override
  String toString() {
    final $this = _this;
    return 'GenericDataClass<${T}, ${S}>(field1: ${$this.field1}, field2: ${$this.field2})';
  }
}

extension $$GenericDataClass<T, S extends Iterable<T>>
    on GenericDataClass<T, S> {
  GenericDataClass<T, S> copyWith({T field1, S field2}) =>
      GenericDataClass(field1 ?? this.field1, field2 ?? this.field2);
}

// *****************************************************************************
// _PrivateDataClass
// *****************************************************************************
@immutable
mixin _$_PrivateDataClass {
  _PrivateDataClass get _this => (this as _PrivateDataClass);
  @override
  bool operator ==(Object other) {
    final $this = _this;
    return identical(this, other) ||
        identical($this.runtimeType, other.runtimeType) &&
            other is _PrivateDataClass &&
            const DeepCollectionEquality().equals(
                [$this.field1, $this.field2], [other.field1, other.field2]);
  }

  @override
  int get hashCode {
    final $this = _this;
    return const DeepCollectionEquality()
        .hash([$this.runtimeType.hashCode, $this.field1, $this.field2]);
  }

  @override
  String toString() {
    final $this = _this;
    return '_PrivateDataClass(field1: ${$this.field1}, field2: ${$this.field2})';
  }
}

extension _$$_PrivateDataClass on _PrivateDataClass {
  _PrivateDataClass Function({int field1, String field2}) get _copyWith =>
      ({field1, Object field2 = unused}) => _PrivateDataClass(
          field1 ?? this.field1,
          field2 == unused ? this.field2 : (field2 as String));
}

// *****************************************************************************
// DataClassWithPrivateConstructor
// *****************************************************************************
@immutable
mixin _$DataClassWithPrivateConstructor {
  DataClassWithPrivateConstructor get _this =>
      (this as DataClassWithPrivateConstructor);
  @override
  bool operator ==(Object other) {
    final $this = _this;
    return identical(this, other) ||
        identical($this.runtimeType, other.runtimeType) &&
            other is DataClassWithPrivateConstructor &&
            const DeepCollectionEquality().equals(
                [$this.field1, $this.field2], [other.field1, other.field2]);
  }

  @override
  int get hashCode {
    final $this = _this;
    return const DeepCollectionEquality()
        .hash([$this.runtimeType.hashCode, $this.field1, $this.field2]);
  }

  @override
  String toString() {
    final $this = _this;
    return 'DataClassWithPrivateConstructor(field1: ${$this.field1}, field2: ${$this.field2})';
  }
}

extension _$$DataClassWithPrivateConstructor
    on DataClassWithPrivateConstructor {
  DataClassWithPrivateConstructor Function({int field1, String field2})
      get _copyWith => ({field1, Object field2 = unused}) =>
          DataClassWithPrivateConstructor._(field1 ?? this.field1,
              field2 == unused ? this.field2 : (field2 as String));
}

// *****************************************************************************
// MutableDataClass
// *****************************************************************************
mixin _$MutableDataClass {
  MutableDataClass get _this => (this as MutableDataClass);
  @override
  bool operator ==(Object other) {
    final $this = _this;
    return identical(this, other) ||
        identical($this.runtimeType, other.runtimeType) &&
            other is MutableDataClass &&
            const DeepCollectionEquality().equals(
                [$this.field1, $this.field2], [other.field1, other.field2]);
  }

  @override
  int get hashCode {
    final $this = _this;
    return const DeepCollectionEquality()
        .hash([$this.runtimeType.hashCode, $this.field1, $this.field2]);
  }

  @override
  String toString() {
    final $this = _this;
    return 'MutableDataClass(field1: ${$this.field1}, field2: ${$this.field2})';
  }
}

extension $$MutableDataClass on MutableDataClass {
  MutableDataClass Function({int field1, String field2}) get copyWith =>
      ({field1, Object field2 = unused}) => MutableDataClass(
          field1: field1 ?? this.field1,
          field2: field2 == unused ? this.field2 : (field2 as String));
}

// *****************************************************************************
// MultipleConstructorDataClass
// *****************************************************************************
@immutable
mixin _$MultipleConstructorDataClass {
  MultipleConstructorDataClass get _this =>
      (this as MultipleConstructorDataClass);
  @override
  bool operator ==(Object other) {
    final $this = _this;
    return identical(this, other) ||
        identical($this.runtimeType, other.runtimeType) &&
            other is MultipleConstructorDataClass &&
            const DeepCollectionEquality()
                .equals([$this.field1], [other.field1]);
  }

  @override
  int get hashCode {
    final $this = _this;
    return const DeepCollectionEquality()
        .hash([$this.runtimeType.hashCode, $this.field1]);
  }

  @override
  String toString() {
    final $this = _this;
    return 'MultipleConstructorDataClass(field1: ${$this.field1})';
  }
}

extension _$$MultipleConstructorDataClass on MultipleConstructorDataClass {
  MultipleConstructorDataClass _copyWith({int field1}) =>
      MultipleConstructorDataClass._(field1 ?? this.field1);
}
