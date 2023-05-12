import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_event.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_state.dart';
import 'package:flutter_velog_sample/app/search/repository/search_repository.dart';
import 'package:flutter_velog_sample/main.dart';

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
      add(SearchFilterSearchingEvent(query: event.query));
    });
    emit(SearchFilterSearchingState(timer: _timer, strings: const []));
  }

  Future<void> _searching(
      SearchFilterSearchingEvent event, Emitter<SearchFilterState> emit) async {
    List<String> _result =
        await SearchRepository.instance.getNaverBlogSearch(query: event.query);
    List<List<String>> _strings =
        _allMatching(strings: _result, query: event.query);
    emit(SearchFilterSearchedState(strings: _strings, query: event.query));
  }

  List<List<String>> _allMatching({
    required List<String> strings,
    required String query,
  }) {
    List<List<String>> _result = [];
    if (strings.isNotEmpty) {
      for (int i = 0; i < strings.length; i++) {
        _result.add(strings[i].split(""));

        // if (query.length > 1) {
        //   int _index = strings[i].indexOf(query);

        //   logger.e(_index);
        //   _result.add(strings[i].split(""));
        // } else {
        //   _result.add(strings[i].split(""));
        // }
      }
    }
    return _result;
  }

  @override
  void onChange(Change<SearchFilterState> change) {
    // logger.e(change);
    super.onChange(change);
  }

  @override
  Future<void> close() {
    state.timer?.cancel();
    return super.close();
  }
}
