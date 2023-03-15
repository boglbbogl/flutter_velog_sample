import 'dart:convert';
import 'dart:io';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:http/http.dart' as http;

class DynamicLinksProvider extends ChangeNotifier {
  Future<void> createDynamicLink(BuildContext context, String content) async {
    HapticFeedback.mediumImpact();
    DynamicLinkParameters _parms = DynamicLinkParameters(
      uriPrefix: "https://tyger.page.link",
      link: Uri.parse("https://tyger.page.link/firebase/dynamicLinks/$content"),
      androidParameters: const AndroidParameters(
        packageName: "com.tyger.flutter_velog_sample",
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: "com.tyger.velogsample",
        minimumVersion: '0',
      ),
    );
    ShortDynamicLink _dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(_parms);
    String _shortLink = _dynamicLink.shortUrl.toString();
    Clipboard.setData(ClipboardData(text: _shortLink));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      _shortLink,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    )));
  }

  Future<void> listener(BuildContext context) async {
    initialDynamicLink(context);
    _backgroundDynamicLink(context);
  }

  Future<void> initialDynamicLink(BuildContext context) async {
    PendingDynamicLinkData? _event =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (_event != null) {
      _onRouter(context, _event.link);
    }
  }

  void _backgroundDynamicLink(BuildContext context) {
    initialDynamicLink(context);
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      _onRouter(context, event.link);
    });
  }

  void _onRouter(BuildContext context, Uri? path) {
    if (path != null) {
      String _deeplink =
          path.toString().replaceAll("https://tyger.page.link/", "");
      Navigator.of(context).pushNamed(_deeplink);
    }
  }

  Future<void> createDynamicLinkWithAPI(
    BuildContext context,
    String content, {
    required String title,
    required String imageUrl,
  }) async {
    HapticFeedback.mediumImpact();
    try {
      String _key = "";
      http.Response _response = await http.post(
        Uri.parse(
            "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=$_key"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "suffix": {
            "option": "SHORT",
          },
          "dynamicLinkInfo": {
            "domainUriPrefix": "https://tyger.page.link",
            "link": "https://tyger.page.link/firebase/dynamicLinks/$content",
            "androidInfo": {
              "androidPackageName": "com.tyger.flutter_velog_sample",
            },
            "iosInfo": {
              "iosBundleId": "com.tyger.velogsample",
            },
            "socialMetaTagInfo": {
              "socialTitle": title,
              "socialImageLink": imageUrl,
            },
          },
        }),
      );
      if (_response.statusCode == 200) {
        Map<String, dynamic> _result = json
            .decode(utf8.decode(_response.bodyBytes)) as Map<String, dynamic>;
        Clipboard.setData(ClipboardData(text: _result["shortLink"]));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          _result["shortLink"],
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )));
      }
    } on HttpException catch (error) {
      logger.e(error);
    }
  }
}
