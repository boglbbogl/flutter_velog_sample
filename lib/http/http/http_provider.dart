import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:http/http.dart' as http;

class HttpProvider extends ChangeNotifier {
  Future<void> started() async {
    await _fetchPost();
  }

  Future<void> _fetchPost() async {
    try {
      final _response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    } catch (error) {
      logger.e(error);
    }
  }
}
