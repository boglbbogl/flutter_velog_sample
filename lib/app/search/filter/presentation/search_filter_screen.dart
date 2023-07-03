import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/search/filter/presentation/search_filter_string_screen.dart';
import 'package:flutter_velog_sample/app/search/filter/presentation/search_filter_strings_screen.dart';

class AppSearchFilterScreen extends StatelessWidget {
  const AppSearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(title: "Search Filtering..."),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button(
              context: context,
              title: "모든 문자 필터링",
              widget: const SearchFilterStringScreen()),
          _button(
              context: context,
              title: "일치 문자열 필터링",
              widget: const SearchFilterStringsScreen()),
        ],
      ),
    );
  }

  GestureDetector _button({
    required String title,
    required Widget widget,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.green,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Center(
            child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.amber, fontSize: 18),
        )),
      ),
    );
  }
}
