import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchRepository {
  static final SearchRepository instance = SearchRepository._internal();
  factory SearchRepository() => instance;
  SearchRepository._internal();

  final String _id = "3Hc_iLDlNe3gHFBIb9iP";
  final String _secret = "0WiczCuIBN";

  Future<List<String>> getNaverBlogSearch({
    required String query,
  }) async {
    try {
      http.Response _response = await http.get(
          Uri.parse(
              "https://openapi.naver.com/v1/search/blog.json?query=$query"),
          headers: {
            "X-Naver-Client-Id": _id,
            "X-Naver-Client-Secret": _secret,
          });
      if (_response.statusCode == 200) {
        Map<String, dynamic> _fromMap = json.decode(_response.body);
        List<dynamic> _data = List.from(_fromMap["items"]).toList();
        List<String> _return = _data.map((e) {
          String _title = e["title"];
          _title = _title.replaceAll("</b>", "");
          _title = _title.replaceAll("<b>", "");
          return _title;
        }).toList();
        return _return;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}
