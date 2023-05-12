import 'dart:ui';

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
      create: (_) => SearchFilterBloc(true),
      child: BlocBuilder<SearchFilterBloc, SearchFilterState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: "일치하는 문자열 필터링"),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: MediaQueryData.fromWindow(window).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.amber,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextFormField(
                      onChanged: (value) {},
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
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
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 4, left: 12, right: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: RichText(
                                      text: TextSpan(children: [
                                    ...List.generate(
                                        state.strings![index].length,
                                        (i) => TextSpan(
                                              text: state.strings![index][i],
                                            ))
                                  ])),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
