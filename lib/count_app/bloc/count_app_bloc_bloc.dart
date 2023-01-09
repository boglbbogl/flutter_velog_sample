import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'count_app_bloc_event.dart';
part 'count_app_bloc_state.dart';

class CountAppBlocBloc extends Bloc<CountAppBlocEvent, CountAppBlocState> {
  CountAppBlocBloc() : super(const CountAppBlocState()) {
    on<CountAppBlocIncrement>(_increment);
    on<CountAppBlocDecrement>(_decrement);
    on<CountAppBlocReset>(_reset);
    on<CountAppBlocSelect>(_select);
    // on<CountAppBlocIncrement>(_increment);
  }

  void _increment(
      CountAppBlocIncrement event, Emitter<CountAppBlocState> emit) {
    emit(state.copyWith(count: state.count + state.selectCount));
  }

  void _decrement(
      CountAppBlocDecrement event, Emitter<CountAppBlocState> emit) {
    emit(state.copyWith(count: state.count - state.selectCount));
  }

  void _reset(CountAppBlocReset event, Emitter<CountAppBlocState> emit) {
    emit(state.copyWith(count: 0));
  }

  void _select(CountAppBlocSelect event, Emitter<CountAppBlocState> emit) {
    emit(state.copyWith(selectCount: event.selectCount));
  }
}
