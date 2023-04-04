import 'package:equatable/equatable.dart';

abstract class ManagementState extends Equatable {
  final int count;
  const ManagementState({
    this.count = 0,
  });
}

class ManagementInitState extends ManagementState {
  @override
  List<Object?> get props => [];
}

class ManagementChangeState extends ManagementState {
  const ManagementChangeState({super.count});
  @override
  List<Object?> get props => [count];
}
