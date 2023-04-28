import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/address/depth/application/address_depth_event.dart';
import 'package:flutter_velog_sample/app/address/depth/application/address_depth_state.dart';
import 'package:flutter_velog_sample/app/address/model/depth/address_depth_model.dart';
import 'package:flutter_velog_sample/app/address/model/depth/address_depth_server_model.dart';
import 'package:flutter_velog_sample/app/address/repository/app_address_repository.dart';

class AddressDepthBloc extends Bloc<AddressDepthEvent, AddressDepthState> {
  final AppAddressRepository _repository = AppAddressRepository.instance;
  AddressDepthBloc()
      : super(AddressDepthMajorState(address: AddressDepthModel.empty())) {
    on<AddressDepthMajorEvent>(_major);
    on<AddressDepthMiddlevent>(_middle);
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
      AddressDepthMiddlevent event, Emitter<AddressDepthState> emit) async {}
}
