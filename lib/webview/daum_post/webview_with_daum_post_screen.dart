import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/webview/daum_post/daum_post_model.dart';
import 'package:flutter_velog_sample/webview/daum_post/webview_with_daum_post_webview.dart';

class WebviewWithDaumPostScreen extends StatefulWidget {
  const WebviewWithDaumPostScreen({super.key});

  @override
  State<WebviewWithDaumPostScreen> createState() =>
      _WebviewWithDaumPostScreenState();
}

class _WebviewWithDaumPostScreenState extends State<WebviewWithDaumPostScreen> {
  DaumPostModel? _dataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Webview With Daum Post"),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                if (_dataModel != null) ...[
                  _text("Address", _dataModel!.address),
                  _text("Road Address", _dataModel!.roadAddress),
                  _text("Jibun Address", _dataModel!.jibunAddress),
                  _text("Sido", _dataModel!.sido),
                  _text("Sigungu", _dataModel!.sigungu),
                  _text("B Name", _dataModel!.bname),
                  _text("Road Name", _dataModel!.roadname),
                  _text("Building Name", _dataModel!.buildingName),
                  _text("Address(EN)", _dataModel!.addressEnglish),
                  _text("Road Address(EN)", _dataModel!.roadAddressEnglish),
                  _text("Jibun Address(EN)", _dataModel!.jibunAddressEnglish),
                  _text("Sido(EN)", _dataModel!.sidoEnglish),
                  _text("Sigungu(EN)", _dataModel!.sigunguEnglish),
                  _text("B Name(EN)", _dataModel!.bnameEnglish),
                  _text("Road Name(EN)", _dataModel!.roadnameEnglish),
                  _text("Zonecode", _dataModel!.zonecode),
                  _text("Sigungu Code", _dataModel!.sigunguCode),
                  _text("B Code", _dataModel!.bcode),
                  _text("Building Code", _dataModel!.buildingCode),
                  _text("Roadname Code", _dataModel!.roadnameCode),
                  _text("Address Type", _dataModel!.addressType),
                  _text("Apertment", _dataModel!.apartment),
                  _text("User Language Type", _dataModel!.userLanguageType),
                  _text("User Selected Type", _dataModel!.userSelectedType),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const WebviewWithDaumPostWebview();
                })).then((value) {
                  if (value != null) {
                    setState(() {
                      _dataModel = value;
                    });
                  }
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      "Daum 주소 검색",
                      style: TextStyle(
                          color: Color.fromRGBO(41, 41, 41, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _text(String title, String expain) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.31,
              child: Center(
                  child: Text(
                title,
                style: const TextStyle(
                    fontSize: 12, color: Color.fromRGBO(195, 195, 195, 1)),
              ))),
          Flexible(
            child: Text(
              expain,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
