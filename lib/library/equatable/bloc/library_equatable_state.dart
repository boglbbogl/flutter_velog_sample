import 'package:equatable/equatable.dart';

class LibraryEquatableState extends Equatable {
  final int count;
  const LibraryEquatableState(this.count);

  @override
  List<Object?> get props => [count];
}
