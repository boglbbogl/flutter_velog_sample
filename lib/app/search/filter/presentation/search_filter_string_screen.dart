import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_bloc.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_event.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_state.dart';

class SearchFilterStringScreen extends StatelessWidget {
  const SearchFilterStringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchFilterBloc(),
      child: BlocBuilder<SearchFilterBloc, SearchFilterState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: appBar(title: "모든 문자 필터링"),
              body: Column(
                children: [
                  Container(
                    width: MediaQueryData.fromWindow(window).size.width,
                    height: 50,
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        onChanged: (value) => context
                            .read<SearchFilterBloc>()
                            .add(SearchFilterTimerEvent(query: value)),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.amber),
                        decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  if (state is SearchFilterSearchingState ||
                      state is SearchFilterSearchedState) ...[
                    Expanded(
                      child: ListView.builder(
                          itemCount: state.strings!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 12),
                              child: RichText(
                                  text: TextSpan(children: [
                                ...List.generate(
                                    state.strings![index].length,
                                    (i) => TextSpan(
                                        text: state.strings![index][i],
                                        style: TextStyle(
                                            color: _isSame(
                                                    query:
                                                        state.query.split(""),
                                                    result: state
                                                        .strings![index][i])
                                                ? Colors.amber
                                                : Colors.white)))
                              ])),
                            );
                          }),
                    )
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isSame({
    required List<String> query,
    required String result,
  }) {
    return query.contains(result) ||
        query.contains(result.toUpperCase()) ||
        query.contains(result.toLowerCase());
  }
}
