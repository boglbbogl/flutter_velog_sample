import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:flutter_velog_sample/management/cubit/management_state.dart';

class ManagementCubit extends Cubit<ManagementState> {
  ManagementCubit() : super(ManagementInitState());

  void increment() {
    emit(ManagementChangeState(count: state.count + 1));
  }

  @override
  void onChange(Change<ManagementState> change) {
    logger.e(change);
    super.onChange(change);
  }
}
