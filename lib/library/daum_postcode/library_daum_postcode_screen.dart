import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/library/daum_postcode/library_daum_postcode_webview.dart';

class LibraryDaumPostcodeScreen extends StatefulWidget {
  const LibraryDaumPostcodeScreen({super.key});

  @override
  State<LibraryDaumPostcodeScreen> createState() =>
      _LibraryDaumPostcodeScreenState();
}

class _LibraryDaumPostcodeScreenState extends State<LibraryDaumPostcodeScreen> {
  DataModel? _dataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Daum Postcode Library"),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: Column(
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
                    .push(MaterialPageRoute(
                        builder: (context) =>
                            const LibraryDaumPostcodeWebview()))
                    .then((value) {
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
                          fontSize: 24,
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
              width: MediaQuery.of(context).size.width * 0.3,
              child: Center(
                  child: Text(
                title,
                style: const TextStyle(
                    fontSize: 13, color: Color.fromRGBO(195, 195, 195, 1)),
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
