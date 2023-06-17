import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/scroll_view/performance/performance_list_builder_screen.dart';
import 'package:flutter_velog_sample/scroll_view/performance/performance_list_view_screen.dart';
import 'package:flutter_velog_sample/scroll_view/performance/performance_sliver_builder_screen.dart';
import 'package:flutter_velog_sample/scroll_view/performance/performance_sliver_view_screen.dart';
import 'package:http/http.dart' as http;

class ScrollViewPerformanceScreen extends StatefulWidget {
  const ScrollViewPerformanceScreen({super.key});

  @override
  State<ScrollViewPerformanceScreen> createState() =>
      _ScrollViewPerformanceScreenState();
}

class _ScrollViewPerformanceScreenState
    extends State<ScrollViewPerformanceScreen> {
  List<String> images = [];
  @override
  void initState() {
    super.initState();
    _fetchPost();
  }

  Future<void> _fetchPost() async {
    http.Response _response = await http
        .get(Uri.parse("https://picsum.photos/v2/list?page=0&limit=100"));
    if (_response.statusCode == 200) {
      List<dynamic> _data = json.decode(_response.body);
      List<String> _images =
          _data.map((e) => e["download_url"].toString()).toList();
      images = _images;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Performance Check"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _title("List"),
          Row(
            children: [
              _button(
                  title: "View",
                  widget: PerformanceListViewScreen(images: images)),
              _button(
                  title: "Builder",
                  widget: PerformanceListBuilderScreen(images: images)),
            ],
          ),
          const SizedBox(height: 40),
          _title("SliverList"),
          Row(
            children: [
              _button(
                  title: "View",
                  widget: PerformanceSliverViewScreen(images: images)),
              _button(
                  title: "Builder",
                  widget: PerformanceSliverBuilderScreen(images: images)),
            ],
          ),
        ],
      ),
    );
  }

  _title(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
      ),
    );
  }

  _button({
    required String title,
    required Widget widget,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.deepOrange,
          ),
          width: MediaQueryData.fromWindow(window).size.width / 2 - 20,
          height: 70,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
