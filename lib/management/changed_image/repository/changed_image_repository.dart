import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ChangedImageRepository {
  static final ChangedImageRepository instance =
      ChangedImageRepository._internal();
  factory ChangedImageRepository() => instance;
  ChangedImageRepository._internal();

  Future<String?> fetchImage({
    required int pageNo,
  }) async {
    try {
      http.Response _response = await http
          .get(Uri.parse("https://picsum.photos/v2/list?page=$pageNo&limit=1"));
      if (_response.statusCode == 200) {
        List<dynamic> _data = json.decode(_response.body);
        if (_data.isNotEmpty) {
          String? _url = _data[0]["download_url"];
          return _url;
        } else {
          return null;
        }
      }
      return null;
    } on HttpException {
      return null;
    }
  }
}
