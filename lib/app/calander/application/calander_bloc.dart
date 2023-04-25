import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/calander/application/calander_event.dart';
import 'package:flutter_velog_sample/app/calander/application/calander_state.dart';
import 'package:flutter_velog_sample/app/calander/model/calander_model.dart';
import 'package:flutter_velog_sample/main.dart';

class CalanderBloc extends Bloc<CalanderEvent, CalanderState> {
  CalanderBloc() : super(CalanderState(calander: CalanderModel.empty())) {
    on<TestEvent>(_test);
  }

  Future<void> _test(TestEvent event, Emitter<CalanderState> emit) async {
    List<TestModel> _test = [];
    _test.add(event.test);
    emit(state.copyWith(calander: state.calander.copyWith(testModel: _test)));
  }

  @override
  void onChange(Change<CalanderState> change) {
    logger.e(change);
    super.onChange(change);
  }
}
