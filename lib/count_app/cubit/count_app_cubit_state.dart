part of 'count_app_cubit_cubit.dart';

class CountAppCubitState extends Equatable {
  final int count;
  final int selectCount;

  const CountAppCubitState({
    this.count = 0,
    this.selectCount = 1,
  });

  CountAppCubitState copyWith({
    int? count,
    int? selectCount,
  }) {
    return CountAppCubitState(
      count: count ?? this.count,
      selectCount: selectCount ?? this.selectCount,
    );
  }

  @override
  List<Object> get props => [count, selectCount];
}
