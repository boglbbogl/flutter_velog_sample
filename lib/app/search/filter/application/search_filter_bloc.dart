import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_event.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_state.dart';
import 'package:flutter_velog_sample/app/search/repository/search_repository.dart';

class SearchFilterBloc extends Bloc<SearchFilterEvent, SearchFilterState> {
  SearchFilterBloc() : super(SearchFilterInitState()) {
    on<SearchFilterSearchingEvent>(_searching);
    add(SearchFilterSearchingEvent());
  }

  Future<void> _searching(
      SearchFilterSearchingEvent event, Emitter<SearchFilterState> emit) async {
    await SearchRepository.instance.getNaverBlogSearch();
  }
}
