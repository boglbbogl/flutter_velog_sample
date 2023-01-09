part of 'count_app_bloc_bloc.dart';

class CountAppBlocState extends Equatable {
  final int count;
  final int selectCount;
  const CountAppBlocState({
    this.count = 0,
    this.selectCount = 1,
  });

  CountAppBlocState copyWith({
    int? count,
    int? selectCount,
  }) {
    return CountAppBlocState(
      count: count ?? this.count,
      selectCount: selectCount ?? this.selectCount,
    );
  }

  @override
  List<Object> get props => [count, selectCount];
}

// class CountAppBlocInitial extends CountAppBlocState {}

// class CountAppBlocLoaded extends CountAppBlocState {
//   final int count;
//   const CountAppBlocLoaded({
//     required this.count,
//   });
//   @override
//   List<Object> get props => [count];
// }
