import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/library/equatable/bloc/library_equatable_event.dart';
import 'package:flutter_velog_sample/library/equatable/bloc/library_equatable_state.dart';

class LibraryEquatableBloc
    extends Bloc<LibraryEquatableEvent, LibraryEquatableState> {
  LibraryEquatableBloc() : super(const LibraryEquatableState(0)) {
    on<IncrementEquatableEvent>(_increment);
    on<ReturnEquatableEvent>(_return);
  }

  void _increment(
      IncrementEquatableEvent event, Emitter<LibraryEquatableState> emit) {
    emit(LibraryEquatableState(state.count + 1));
  }

  void _return(
      ReturnEquatableEvent event, Emitter<LibraryEquatableState> emit) {
    emit(LibraryEquatableState(state.count));
  }
}
