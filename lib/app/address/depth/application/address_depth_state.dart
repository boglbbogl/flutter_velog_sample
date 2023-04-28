import 'package:equatable/equatable.dart';
import 'package:flutter_velog_sample/app/address/model/depth/address_depth_model.dart';

abstract class AddressDepthState extends Equatable {
  final String? accessToken;
  final AddressDepthModel? address;
  const AddressDepthState({
    this.accessToken,
    this.address,
  });
}

class AddressDepthInitState extends AddressDepthState {
  const AddressDepthInitState({super.address});
  @override
  List<Object?> get props => [address];
}

class AddressDepthMajorState extends AddressDepthState {
  const AddressDepthMajorState({super.accessToken, super.address});
  @override
  List<Object?> get props => [address, accessToken];
}

class AddressDepthMiddleState extends AddressDepthState {
  const AddressDepthMiddleState({super.accessToken, super.address});

  @override
  List<Object?> get props => [address];
}

class AddressDepthMinorState extends AddressDepthState {
  const AddressDepthMinorState({super.accessToken, super.address});

  @override
  List<Object?> get props => [address];
}

class AddressDepthErrorState extends AddressDepthState {
  const AddressDepthErrorState({super.address});
  @override
  List<Object?> get props => [];
}
