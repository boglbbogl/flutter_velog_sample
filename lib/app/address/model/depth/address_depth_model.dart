import 'package:flutter_velog_sample/app/address/model/depth/address_depth_server_model.dart';

class AddressDepthModel {
  final AddressDepthDetailModel major;
  final AddressDepthDetailModel middle;
  final AddressDepthDetailModel minor;

  AddressDepthModel({
    required this.major,
    required this.middle,
    required this.minor,
  });

  factory AddressDepthModel.empty() => AddressDepthModel(
      major: AddressDepthDetailModel.empty(),
      middle: AddressDepthDetailModel.empty(),
      minor: AddressDepthDetailModel.empty());

  AddressDepthModel coptyWith({
    final AddressDepthDetailModel? major,
    final AddressDepthDetailModel? middle,
    final AddressDepthDetailModel? minor,
  }) {
    return AddressDepthModel(
      major: major ?? this.major,
      middle: middle ?? this.middle,
      minor: minor ?? this.minor,
    );
  }
}

class AddressDepthDetailModel {
  final AddressDepthServerModel? current;
  final List<AddressDepthServerModel> address;

  AddressDepthDetailModel({
    required this.current,
    required this.address,
  });

  factory AddressDepthDetailModel.empty() =>
      AddressDepthDetailModel(current: null, address: []);

  AddressDepthDetailModel copyWith({
    final AddressDepthServerModel? current,
    final List<AddressDepthServerModel>? address,
  }) {
    return AddressDepthDetailModel(
      current: current,
      address: address ?? this.address,
    );
  }
}
