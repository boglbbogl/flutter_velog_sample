import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_bloc.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_state.dart';

class AppSearchFilterScreen extends StatelessWidget {
  const AppSearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchFilterBloc>(
      create: (_) => SearchFilterBloc(),
      child: BlocBuilder<SearchFilterBloc, SearchFilterState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: "Search Filtering..."),
          );
        },
      ),
    );
  }
}
