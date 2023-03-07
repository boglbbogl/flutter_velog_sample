import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/main.dart';

class DynamicLinksProvider extends ChangeNotifier {
  String? dynamicLink;

  // DynamicLinksProvider() {
  //   initialDynamicLink();
  //   dynamicLinkListener();
  // }

  Future<void> initialDynamicLink() async {
    PendingDynamicLinkData? _data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (_data != null) {
      dynamicLink = _data.link.path;
      notifyListeners();
    }
  }

  Future<void> dynamicLinkListener() async {
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      logger.e(event);
    });
  }
}
