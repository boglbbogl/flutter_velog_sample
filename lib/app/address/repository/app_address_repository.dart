import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/app/address/model/depth/address_depth_server_model.dart';
import 'package:flutter_velog_sample/app/address/model/step/address_step_model.dart';
import 'package:http/http.dart' as http;

class AppAddressRepository {
  static final AppAddressRepository instance = AppAddressRepository._internal();
  factory AppAddressRepository() => instance;
  AppAddressRepository._internal();

  Future<List<AddressStepModel>> assetsJsonToAddress() async {
    String _major =
        await rootBundle.loadString("assets/json/address_major.json");
    List<dynamic> _data = json.decode(_major)["result"];
    List<AddressStepMinor> _majors =
        _data.map((e) => AddressStepMinor.fromJson(e)).toList();
    List<AddressStepModel> _address = [];
    for (int i = 0; i < _majors.length; i++) {
      String _minor = await rootBundle
          .loadString("assets/json/minor/address_minor_${i + 1}.json");
      List<dynamic> _minorData = json.decode(_minor)["result"];
      List<AddressStepMinor> _minors =
          _minorData.map((e) => AddressStepMinor.fromJson(e)).toList();
      _address.add(AddressStepModel(name: _majors[i].name, names: _minors));
    }
    return _address;
  }

  Future<String?> getSgisApiAccessToken() async {
    try {
      const String _key = "3e3a34227a934b0babef";
      const String _secret = "ea9b93132fac4d128967";
      http.Response _response = await http.get(
        Uri.parse(
            "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json?consumer_key=$_key&consumer_secret=$_secret"),
      );
      if (_response.statusCode == 200) {
        Map<String, dynamic> _body =
            json.decode(_response.body) as Map<String, dynamic>;
        String _accessToken = _body["result"]["accessToken"];
        return _accessToken;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<List<AddressDepthServerModel>> depthAddressInformation({
    required String token,
    String? code,
  }) async {
    try {
      String? _code = code == null ? "" : "&cd=$code";
      http.Response _response = await http.get(Uri.parse(
          "https://sgisapi.kostat.go.kr/OpenAPI3/addr/stage.json?accessToken=$token$_code"));
      if (_response.statusCode == 200) {
        Map<String, dynamic> _body =
            json.decode(_response.body) as Map<String, dynamic>;
        List<dynamic> _result = _body["result"];
        List<AddressDepthServerModel> _model =
            _result.map((e) => AddressDepthServerModel.fromJson(e)).toList();
        return _model;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}
