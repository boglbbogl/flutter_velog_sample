import 'package:freezed_annotation/freezed_annotation.dart';

part 'car_order_data.freezed.dart';

@freezed
class CarOrderData with _$CarOrderData {
  const factory CarOrderData({
    required int orderNumber,
    required String orderName,
    required int orderPhoneNumber,
  }) = _CarOrderData;
}
