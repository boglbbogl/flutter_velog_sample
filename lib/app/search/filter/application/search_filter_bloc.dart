import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_event.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_state.dart';
import 'package:flutter_velog_sample/app/search/repository/search_repository.dart';

class SearchFilterBloc extends Bloc<SearchFilterEvent, SearchFilterState> {
  SearchFilterBloc() : super(SearchFilterInitState()) {
    on<SearchFilterSearchingEvent>(_searching);
    on<SearchFilterTimerEvent>(_timer);
  }

  Future<void> _timer(
      SearchFilterTimerEvent event, Emitter<SearchFilterState> emit) async {
    if (state.timer != null) {
      state.timer?.cancel();
    }
    Timer? _timer;
    _timer = Timer(const Duration(milliseconds: 1000), () {
      state.timer?.cancel();
      add(SearchFilterSearchingEvent());
    });
    emit(SearchFilterSearchingState(timer: _timer));
  }

  Future<void> _searching(
      SearchFilterSearchingEvent event, Emitter<SearchFilterState> emit) async {
    await SearchRepository.instance.getNaverBlogSearch(query: "테스트");
  }
}
