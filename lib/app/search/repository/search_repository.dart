import 'package:flutter_velog_sample/main.dart';
import 'package:http/http.dart' as http;

class SearchRepository {
  static final SearchRepository instance = SearchRepository._internal();
  factory SearchRepository() => instance;
  SearchRepository._internal();

  Future<void> getNaverBlogSearch() async {
    try {
      http.Response _response = await http.get(
          Uri.parse("https://openapi.naver.com/v1/search/blog.json?query=테스트"),
          headers: {
            "X-Naver-Client-Id": "3Hc_iLDlNe3gHFBIb9iP",
            "X-Naver-Client-Secret": "0WiczCuIBN"
          });
      if (_response.statusCode == 200) {
        logger.e(_response.body);
      }
    } catch (error) {
      //
    }
  }
}
