import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/time_line/application/time_line_event.dart';
import 'package:flutter_velog_sample/app/time_line/application/time_line_state.dart';
import 'package:flutter_velog_sample/app/time_line/model/time_line_model.dart';
import 'package:flutter_velog_sample/app/time_line/repository/time_line_repository.dart';

class TimeLineBloc extends Bloc<TimeLineEvent, TimeLineState> {
  TimeLineBloc() : super(const TimeLineLoadingState(timeLines: [])) {
    on<TimeLineLoadEvent>(_load);
    add(TimeLineLoadEvent());
  }

  Future<void> _load(
      TimeLineLoadEvent event, Emitter<TimeLineState> emit) async {
    List<TimeLineModel>? result =
        await TimeLineRepository.instance.getTimeLine();
    if (result != null) {
      DateTime? previous;
      int diffMin = -(24 * 60);
      for (int i = 0; i < result.length; i++) {
        if (previous == null) {
          previous = result[i].time.toDate();
        } else {
          int _diff = result[i].time.toDate().difference(previous).inMinutes;
          if (_diff > diffMin) {
            diffMin = _diff;
          }
          previous = result[i].time.toDate();
        }
      }
      emit(TimeLineLoadedState(timeLines: result));
    }
  }
}
