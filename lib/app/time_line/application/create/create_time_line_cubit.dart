import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/time_line/application/create/create_time_line_state.dart';
import 'package:flutter_velog_sample/app/time_line/model/time_line_model.dart';
import 'package:flutter_velog_sample/app/time_line/repository/time_line_repository.dart';

class CreateTimeLineCubit extends Cubit<CreateTimeLineState> {
  CreateTimeLineCubit()
      : super(CreateTimeLineState(typeList: const [], time: DateTime.now()));

  void init() async {
    emit(state.copyWith(
        typeList: ["밥먹기", "잠자기", "출근하기", "운동하기", "놀기", "데이트하기", "술먹기"]));
  }

  Future<void> submitted() async {
    TimeLineModel _model = TimeLineModel(
      time: Timestamp.fromDate(state.time),
      type: state.type!,
      content: state.content!,
    );
    TimeLineModel? _result =
        await TimeLineRepository.instance.setTimeLine(_model);
    if (_result != null) {
      emit(state.copyWith(isSuccess: true));
    }
  }

  void changedDateTime(DateTime? date, TimeOfDay? time) {
    DateTime dateTime = state.time;
    if (date != null) {
      dateTime = date.copyWith(
          hour: dateTime.hour, minute: dateTime.minute, second: 0);
    }
    if (time != null) {
      dateTime =
          dateTime.copyWith(hour: time.hour, minute: time.minute, second: 0);
    }
    emit(state.copyWith(time: dateTime));
  }

  void _checked() {
    if (state.content != null && state.type != null) {
      emit(state.copyWith(isSubmitted: true));
    } else {
      emit(state.copyWith(isSubmitted: false));
    }
  }

  void selectType(String type) {
    emit(state.copyWith(type: type));
    _checked();
  }

  void inputContent(String value) {
    emit(state.copyWith(content: value.isEmpty ? null : value));
    _checked();
  }
}
