import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/address/depth/application/address_depth_event.dart';
import 'package:flutter_velog_sample/app/address/depth/application/address_depth_state.dart';
import 'package:flutter_velog_sample/app/address/model/depth/address_depth_model.dart';
import 'package:flutter_velog_sample/app/address/model/depth/address_depth_server_model.dart';
import 'package:flutter_velog_sample/app/address/repository/app_address_repository.dart';
import 'package:flutter_velog_sample/main.dart';

class AddressDepthBloc extends Bloc<AddressDepthEvent, AddressDepthState> {
  final AppAddressRepository _repository = AppAddressRepository.instance;
  AddressDepthBloc()
      : super(AddressDepthInitState(address: AddressDepthModel.empty())) {
    on<AddressDepthMajorEvent>(_major);
    on<AddressDepthMiddleEvent>(_middle);
    on<AddressDepthMinorEvent>(_minor);
    add(AddressDepthMajorEvent());
  }

  Future<void> _major(
      AddressDepthMajorEvent event, Emitter<AddressDepthState> emit) async {
    if (state.address!.major.address.isEmpty) {
      String? _token = state.accessToken;
      if (_token == null) {
        String? _result = await _repository.getSgisApiAccessToken();
        if (_result == null) {
          emit(AddressDepthErrorState(address: state.address));
        } else {
          _token = _result;
        }
      }
      if (_token != null) {
        List<AddressDepthServerModel> _result =
            await _repository.depthAddressInformation(token: _token);
        if (_result.isNotEmpty) {
          emit(AddressDepthMajorState(
              address: state.address!.coptyWith(
                major: AddressDepthDetailModel(current: null, address: _result),
              ),
              accessToken: _token));
        } else {
          emit(AddressDepthErrorState(address: state.address));
        }
      }
    }
  }

  Future<void> _middle(
      AddressDepthMiddleEvent event, Emitter<AddressDepthState> emit) async {
    HapticFeedback.mediumImpact();
    List<AddressDepthServerModel> _result = await _repository
        .depthAddressInformation(token: state.accessToken!, code: event.code);
    if (_result.isNotEmpty) {
      emit(AddressDepthMiddleState(
          address: state.address!.coptyWith(
            middle: AddressDepthDetailModel(current: null, address: _result),
          ),
          accessToken: state.accessToken));
    } else {
      emit(AddressDepthErrorState(address: state.address));
    }
  }

  Future<void> _minor(
      AddressDepthMinorEvent event, Emitter<AddressDepthState> emit) async {
    HapticFeedback.mediumImpact();
    List<AddressDepthServerModel> _result = await _repository
        .depthAddressInformation(token: state.accessToken!, code: event.code);
    if (_result.isNotEmpty) {
      emit(AddressDepthMinorState(
          address: state.address!.coptyWith(
            minor: AddressDepthDetailModel(current: null, address: _result),
          ),
          accessToken: state.accessToken));
    } else {
      emit(AddressDepthErrorState(address: state.address));
    }
  }

  @override
  void onChange(Change<AddressDepthState> change) {
    logger.e(change);
    super.onChange(change);
  }
}
