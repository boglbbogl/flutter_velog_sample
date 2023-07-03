import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_bloc.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_event.dart';
import 'package:flutter_velog_sample/app/search/filter/application/search_filter_state.dart';

class SearchFilterStringsScreen extends StatelessWidget {
  const SearchFilterStringsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchFilterBloc(true),
      child: BlocBuilder<SearchFilterBloc, SearchFilterState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: appBar(title: "일치하는 문자열 필터링"),
              body: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.amber,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        onChanged: (value) => context
                            .read<SearchFilterBloc>()
                            .add(SearchFilterTimerEvent(query: value)),
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
                          itemCount: state.filterings!.length,
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
                                          state.filterings![index].length,
                                          (i) => TextSpan(
                                                text: state
                                                    .filterings![index][i]
                                                    .entries
                                                    .first
                                                    .key
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: _isSame(
                                                          state.filterings![
                                                              index][i])
                                                      ? FontWeight.bold
                                                      : null,
                                                  color: _isSame(
                                                          state.filterings![
                                                              index][i])
                                                      ? Colors.orange
                                                      : const Color.fromRGBO(
                                                          215, 215, 215, 1),
                                                ),
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
            ),
          );
        },
      ),
    );
  }

  bool _isSame(Map<String, int> strings) {
    return strings.entries.first.value == 1;
  }
}
