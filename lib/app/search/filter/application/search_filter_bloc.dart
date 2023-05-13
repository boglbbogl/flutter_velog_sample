import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_event.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_state.dart';
import 'package:flutter_velog_sample/app/search/repository/search_repository.dart';

class SearchFilterBloc extends Bloc<SearchFilterEvent, SearchFilterState> {
  final bool isFilter;
  SearchFilterBloc(this.isFilter) : super(SearchFilterInitState()) {
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
    emit(SearchFilterSearchingState(
        timer: _timer, strings: const [], filterings: const []));
  }

  Future<void> _searching(
      SearchFilterSearchingEvent event, Emitter<SearchFilterState> emit) async {
    List<String> _result =
        await SearchRepository.instance.getNaverBlogSearch(query: event.query);
    if (isFilter) {
      List<List<Map<String, int>>> _strings =
          _filtering(strings: _result, query: event.query);
      emit(SearchFilterSearchedState(query: event.query, filterings: _strings));
    } else {
      List<List<String>> _strings =
          _allMatching(strings: _result, query: event.query);
      emit(SearchFilterSearchedState(strings: _strings, query: event.query));
    }
  }

  List<List<Map<String, int>>> _filtering({
    required String query,
    required List<String> strings,
  }) {
    List<List<Map<String, int>>> _result = [];
    if (strings.isNotEmpty) {
      for (int i = 0; i < strings.length; i++) {
        List<Map<String, int>> _toMap = [];
        if (strings[i].toLowerCase().contains(query.toLowerCase())) {
          int _splitIndex =
              strings[i].toLowerCase().indexOf(query.toLowerCase());
          String _first = strings[i].substring(0, _splitIndex);
          String _last = strings[i]
              .substring(_splitIndex + query.length, strings[i].length);
          if (_splitIndex == 0 && strings[i].length - 1 == _splitIndex) {
            _toMap.addAll([
              {strings[i]: 1}
            ]);
          } else if (_splitIndex == 0 && strings[i].length - 1 != _splitIndex) {
            _toMap.addAll([
              {strings[i].replaceFirst(_last, ""): 1},
              {_last: 0}
            ]);
          } else if (_splitIndex != 0 && strings[i].length - 1 == _splitIndex) {
            _toMap.addAll([
              {_first: 0},
              {strings[i].replaceFirst(_first, ""): 1}
            ]);
          } else {
            String _query = strings[i].replaceFirst(_first, "");
            _query = _query.replaceFirst(_last, "");
            _toMap.addAll([
              {_first: 0},
              {_query: 1},
              {_last: 0}
            ]);
          }
        } else {
          _toMap.add({strings[i]: 0});
        }
        _result.add(_toMap);
      }
    }
    return _result;
  }

  List<List<String>> _allMatching({
    required List<String> strings,
    required String query,
  }) {
    List<List<String>> _result = [];
    if (strings.isNotEmpty) {
      for (int i = 0; i < strings.length; i++) {
        _result.add(strings[i].split(""));
      }
    }
    return _result;
  }

  @override
  void onChange(Change<SearchFilterState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() {
    state.timer?.cancel();
    return super.close();
  }
}
