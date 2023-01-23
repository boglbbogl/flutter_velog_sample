// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_sample_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FreezedSampleData _$FreezedSampleDataFromJson(Map<String, dynamic> json) {
  return _FreezedSampleData.fromJson(json);
}

/// @nodoc
mixin _$FreezedSampleData {
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  int get sex => throw _privateConstructorUsedError;
  bool get isMarried => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FreezedSampleDataCopyWith<FreezedSampleData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreezedSampleDataCopyWith<$Res> {
  factory $FreezedSampleDataCopyWith(
          FreezedSampleData value, $Res Function(FreezedSampleData) then) =
      _$FreezedSampleDataCopyWithImpl<$Res, FreezedSampleData>;
  @useResult
  $Res call({String name, int age, String address, int sex, bool isMarried});
}

/// @nodoc
class _$FreezedSampleDataCopyWithImpl<$Res, $Val extends FreezedSampleData>
    implements $FreezedSampleDataCopyWith<$Res> {
  _$FreezedSampleDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? address = null,
    Object? sex = null,
    Object? isMarried = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      sex: null == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as int,
      isMarried: null == isMarried
          ? _value.isMarried
          : isMarried // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FreezedSampleDataCopyWith<$Res>
    implements $FreezedSampleDataCopyWith<$Res> {
  factory _$$_FreezedSampleDataCopyWith(_$_FreezedSampleData value,
          $Res Function(_$_FreezedSampleData) then) =
      __$$_FreezedSampleDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int age, String address, int sex, bool isMarried});
}

/// @nodoc
class __$$_FreezedSampleDataCopyWithImpl<$Res>
    extends _$FreezedSampleDataCopyWithImpl<$Res, _$_FreezedSampleData>
    implements _$$_FreezedSampleDataCopyWith<$Res> {
  __$$_FreezedSampleDataCopyWithImpl(
      _$_FreezedSampleData _value, $Res Function(_$_FreezedSampleData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? address = null,
    Object? sex = null,
    Object? isMarried = null,
  }) {
    return _then(_$_FreezedSampleData(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      sex: null == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as int,
      isMarried: null == isMarried
          ? _value.isMarried
          : isMarried // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FreezedSampleData extends _FreezedSampleData {
  const _$_FreezedSampleData(
      {required this.name,
      required this.age,
      required this.address,
      required this.sex,
      required this.isMarried})
      : super._();

  factory _$_FreezedSampleData.fromJson(Map<String, dynamic> json) =>
      _$$_FreezedSampleDataFromJson(json);

  @override
  final String name;
  @override
  final int age;
  @override
  final String address;
  @override
  final int sex;
  @override
  final bool isMarried;

  @override
  String toString() {
    return 'FreezedSampleData(name: $name, age: $age, address: $address, sex: $sex, isMarried: $isMarried)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FreezedSampleData &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.isMarried, isMarried) ||
                other.isMarried == isMarried));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, age, address, sex, isMarried);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FreezedSampleDataCopyWith<_$_FreezedSampleData> get copyWith =>
      __$$_FreezedSampleDataCopyWithImpl<_$_FreezedSampleData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FreezedSampleDataToJson(
      this,
    );
  }
}

abstract class _FreezedSampleData extends FreezedSampleData {
  const factory _FreezedSampleData(
      {required final String name,
      required final int age,
      required final String address,
      required final int sex,
      required final bool isMarried}) = _$_FreezedSampleData;
  const _FreezedSampleData._() : super._();

  factory _FreezedSampleData.fromJson(Map<String, dynamic> json) =
      _$_FreezedSampleData.fromJson;

  @override
  String get name;
  @override
  int get age;
  @override
  String get address;
  @override
  int get sex;
  @override
  bool get isMarried;
  @override
  @JsonKey(ignore: true)
  _$$_FreezedSampleDataCopyWith<_$_FreezedSampleData> get copyWith =>
      throw _privateConstructorUsedError;
}
