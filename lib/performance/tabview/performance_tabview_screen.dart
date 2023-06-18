import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/performance/tabview/performance_image_tab_widget.dart';
import 'package:http/http.dart' as http;

class PerformanceTabViewScreen extends StatefulWidget {
  const PerformanceTabViewScreen({super.key});

  @override
  State<PerformanceTabViewScreen> createState() =>
      _PerformanceTabViewScreenState();
}

class _PerformanceTabViewScreenState extends State<PerformanceTabViewScreen> {
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
      setState(() {
        images = _images;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar(title: "Tabbar Performance"),
        body: TabBarView(
          children: [
            PerformanceImageTabWidget(images: images),
            Container(),
          ],
        ),
      ),
    );
  }
}
