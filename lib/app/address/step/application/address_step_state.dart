import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/app/address/model/step/address_step_model.dart';

class AddressStepState extends Equatable {
  final List<AddressStepModel>? address;
  final int positionIndex;
  final List<GlobalKey>? globalKeys;
  final bool isLoading;
  final double currentHeight;

  const AddressStepState({
    this.address,
    this.positionIndex = 0,
    this.globalKeys,
    this.isLoading = false,
    this.currentHeight = 0.0,
  });

  AddressStepState copyWith({
    final List<AddressStepModel>? address,
    final int? positionIndex,
    final List<GlobalKey>? globalKeys,
    final bool? isLoading,
    final double? currentHeight,
  }) {
    return AddressStepState(
      address: address ?? this.address,
      positionIndex: positionIndex ?? this.positionIndex,
      globalKeys: globalKeys ?? this.globalKeys,
      isLoading: isLoading ?? this.isLoading,
      currentHeight: currentHeight ?? this.currentHeight,
    );
  }

  @override
  List<Object?> get props => [address, positionIndex, globalKeys, isLoading];
}
