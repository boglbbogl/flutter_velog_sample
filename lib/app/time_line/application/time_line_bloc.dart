import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/time_line/application/time_line_event.dart';
import 'package:flutter_velog_sample/app/time_line/application/time_line_state.dart';
import 'package:flutter_velog_sample/app/time_line/model/time_line_model.dart';
import 'package:flutter_velog_sample/app/time_line/repository/time_line_repository.dart';

class TimeLineBloc extends Bloc<TimeLineEvent, TimeLineState> {
  TimeLineBloc()
      : super(TimeLineLoadingState(
            timeLines: const [], currentDate: DateTime.now())) {
    on<TimeLineLoadEvent>(_load);
    add(TimeLineLoadEvent());
    on<TimeLineDateChangeEvent>(_dateChange);
    on<TimeLineSyncEvent>(_sync);
    on<TimeLineStandardChangeEvent>(_standardChange);
  }

  Future<void> _standardChange(
      TimeLineStandardChangeEvent event, Emitter<TimeLineState> emit) async {
    double index = event.isIncrement
        ? state.standardIndex + 0.1
        : state.standardIndex - 0.1;
    index = index <= 0
        ? 1
        : index > 7
            ? 7.0
            : index;
    emit(TimeLineLoadedState(
        timeLines: state.timeLines,
        interval: state.interval,
        currentDate: state.currentDate,
        standardIndex: index));
  }

  Future<void> _sync(
      TimeLineSyncEvent event, Emitter<TimeLineState> emit) async {
    int _diff = state.currentDate.difference(event.dateTime).inDays;
    if (_diff == 0) {
      add(TimeLineLoadEvent(date: state.currentDate));
    }
  }

  Future<void> _dateChange(
      TimeLineDateChangeEvent event, Emitter<TimeLineState> emit) async {
    DateTime date = state.currentDate;
    date = date.add(Duration(days: event.isIncrement ? 1 : -1));
    add(TimeLineLoadEvent(date: date));
  }

  Future<void> _load(
      TimeLineLoadEvent event, Emitter<TimeLineState> emit) async {
    if (state is! TimeLineLoadingState) {
      emit(TimeLineChangeLoadingState(
        timeLines: state.timeLines,
        currentDate: state.currentDate,
        interval: state.interval,
        standardIndex: state.standardIndex,
      ));
    }
    if (state is TimeLineChangeLoadingState || state is TimeLineLoadingState) {
      List<TimeLineModel>? result =
          await TimeLineRepository.instance.getTimeLine(date: event.date);
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
            result[i] = result[i].copyWith(interval: _diff.abs());
          }
        }
        emit(TimeLineLoadedState(
          timeLines: result,
          interval: diffMin.abs(),
          currentDate: event.date ?? DateTime.now(),
          standardIndex: state.standardIndex,
        ));
      } else {
        emit(TimeLineLoadedState(
          timeLines: const [],
          interval: 0,
          currentDate: event.date ?? DateTime.now(),
          standardIndex: state.standardIndex,
        ));
      }
    }
  }
}
