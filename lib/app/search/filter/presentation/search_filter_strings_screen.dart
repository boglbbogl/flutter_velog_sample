import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_bloc.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_state.dart';

class SearchFilterStringsScreen extends StatelessWidget {
  const SearchFilterStringsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchFilterBloc(),
      child: BlocBuilder<SearchFilterBloc, SearchFilterState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: "일치하는 문자열 필터링"),
          );
        },
      ),
    );
  }
}
