// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'car_order_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CarOrderData {
  int get orderNumber => throw _privateConstructorUsedError;
  String get orderName => throw _privateConstructorUsedError;
  int get orderPhoneNumber => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CarOrderDataCopyWith<CarOrderData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarOrderDataCopyWith<$Res> {
  factory $CarOrderDataCopyWith(
          CarOrderData value, $Res Function(CarOrderData) then) =
      _$CarOrderDataCopyWithImpl<$Res, CarOrderData>;
  @useResult
  $Res call({int orderNumber, String orderName, int orderPhoneNumber});
}

/// @nodoc
class _$CarOrderDataCopyWithImpl<$Res, $Val extends CarOrderData>
    implements $CarOrderDataCopyWith<$Res> {
  _$CarOrderDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderNumber = null,
    Object? orderName = null,
    Object? orderPhoneNumber = null,
  }) {
    return _then(_value.copyWith(
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      orderName: null == orderName
          ? _value.orderName
          : orderName // ignore: cast_nullable_to_non_nullable
              as String,
      orderPhoneNumber: null == orderPhoneNumber
          ? _value.orderPhoneNumber
          : orderPhoneNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CarOrderDataCopyWith<$Res>
    implements $CarOrderDataCopyWith<$Res> {
  factory _$$_CarOrderDataCopyWith(
          _$_CarOrderData value, $Res Function(_$_CarOrderData) then) =
      __$$_CarOrderDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int orderNumber, String orderName, int orderPhoneNumber});
}

/// @nodoc
class __$$_CarOrderDataCopyWithImpl<$Res>
    extends _$CarOrderDataCopyWithImpl<$Res, _$_CarOrderData>
    implements _$$_CarOrderDataCopyWith<$Res> {
  __$$_CarOrderDataCopyWithImpl(
      _$_CarOrderData _value, $Res Function(_$_CarOrderData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderNumber = null,
    Object? orderName = null,
    Object? orderPhoneNumber = null,
  }) {
    return _then(_$_CarOrderData(
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      orderName: null == orderName
          ? _value.orderName
          : orderName // ignore: cast_nullable_to_non_nullable
              as String,
      orderPhoneNumber: null == orderPhoneNumber
          ? _value.orderPhoneNumber
          : orderPhoneNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_CarOrderData implements _CarOrderData {
  const _$_CarOrderData(
      {required this.orderNumber,
      required this.orderName,
      required this.orderPhoneNumber});

  @override
  final int orderNumber;
  @override
  final String orderName;
  @override
  final int orderPhoneNumber;

  @override
  String toString() {
    return 'CarOrderData(orderNumber: $orderNumber, orderName: $orderName, orderPhoneNumber: $orderPhoneNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CarOrderData &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.orderName, orderName) ||
                other.orderName == orderName) &&
            (identical(other.orderPhoneNumber, orderPhoneNumber) ||
                other.orderPhoneNumber == orderPhoneNumber));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, orderNumber, orderName, orderPhoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CarOrderDataCopyWith<_$_CarOrderData> get copyWith =>
      __$$_CarOrderDataCopyWithImpl<_$_CarOrderData>(this, _$identity);
}

abstract class _CarOrderData implements CarOrderData {
  const factory _CarOrderData(
      {required final int orderNumber,
      required final String orderName,
      required final int orderPhoneNumber}) = _$_CarOrderData;

  @override
  int get orderNumber;
  @override
  String get orderName;
  @override
  int get orderPhoneNumber;
  @override
  @JsonKey(ignore: true)
  _$$_CarOrderDataCopyWith<_$_CarOrderData> get copyWith =>
      throw _privateConstructorUsedError;
}
