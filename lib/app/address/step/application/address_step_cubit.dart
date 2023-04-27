import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/address/model/step/address_step_model.dart';
import 'package:flutter_velog_sample/app/address/repository/app_address_repository.dart';
import 'package:flutter_velog_sample/app/address/step/application/address_step_state.dart';

class AddressStepCubit extends Cubit<AddressStepState> {
  final AppAddressRepository _repository = AppAddressRepository.instance;
  AddressStepCubit() : super(const AddressStepState());

  Future<void> started() async {
    List<AddressStepModel> _address = await _repository.assetsJsonToAddress();
    emit(state.copyWith(
      address: _address,
      globalKeys: List.generate(_address.length, (_) => GlobalKey()),
    ));
  }

  Future<void> tapToScrollAnimated({
    required int index,
    required ScrollController controller,
  }) async {
    if (state.globalKeys != null) {
      double _height = 0.0;
      for (int i = 0; i < index; i++) {
        if (state.globalKeys![i].currentContext != null) {
          _height = _height + state.globalKeys![i].currentContext!.size!.height;
        }
      }

      controller.animateTo(_height - 50 * (index - 1) - 29,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  Future<void> scrollListener(ScrollUpdateNotification noti) async {
    if (state.globalKeys != null) {
      if (state.globalKeys![state.positionIndex].currentContext != null) {
        double _widgetHeight =
            state.globalKeys![state.positionIndex].currentContext!.size!.height;
        double _currentPixel = noti.metrics.pixels;
        if ((_widgetHeight + state.currentHeight) -
                ((state.positionIndex + 1) * 50 - 12) <
            _currentPixel) {
          if (!state.isLoading) {
            emit(state.copyWith(isLoading: true));
            emit(state.copyWith(
                isLoading: false,
                positionIndex: state.address!.length - 2 < state.positionIndex
                    ? state.positionIndex
                    : state.positionIndex + 1,
                currentHeight: state.address!.length - 2 < state.positionIndex
                    ? state.currentHeight
                    : _widgetHeight + state.currentHeight));
          }
        } else if (state.currentHeight - ((state.positionIndex * 50) + 12) >
            _currentPixel) {
          emit(state.copyWith(isLoading: true));
          int _changeIndex = 0;
          double _changeHeight = 0;
          if (state.positionIndex - 1 > 0) {
            _changeIndex = state.positionIndex - 1;
            _changeHeight =
                state.globalKeys![_changeIndex].currentContext!.size!.height;
          } else {
            _changeHeight = state.globalKeys![0].currentContext!.size!.height;
          }
          emit(state.copyWith(
              isLoading: false,
              positionIndex: _changeIndex,
              currentHeight: state.currentHeight - _changeHeight < 0
                  ? 0
                  : state.currentHeight - _changeHeight));
        }
      }
    } else {
      emit(state.copyWith(
          globalKeys:
              List.generate(state.address!.length, (_) => GlobalKey())));
    }
  }
}
