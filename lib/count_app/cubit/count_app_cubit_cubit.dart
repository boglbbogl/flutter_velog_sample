import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'count_app_cubit_state.dart';

class CountAppCubitCubit extends Cubit<CountAppCubitState> {
  CountAppCubitCubit() : super(const CountAppCubitState());

  void increment() {
    emit(state.copyWith(count: state.count + state.selectCount));
  }

  void decrement() {
    emit(state.copyWith(count: state.count - state.selectCount));
  }

  void reset() {
    emit(state.copyWith(count: 0));
  }

  void select(int count) {
    emit(state.copyWith(selectCount: count));
  }
}
