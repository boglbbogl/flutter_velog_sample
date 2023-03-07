import 'dart:ui';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/main.dart';

class FirebaseDynamicLinksScreen extends StatelessWidget {
  const FirebaseDynamicLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Firebase Dynamic Links"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button(
            context: context,
            content: "nomal",
          ),
          _button(
            context: context,
            content: "argument",
          ),
          _button(
            context: context,
            content: "multi",
          ),
        ],
      ),
    );
  }

  Padding _button({
    required BuildContext context,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context)
                  .pushNamed("/firebase/dynamicLinks/$content");
            },
            child: Container(
              width: MediaQueryData.fromWindow(window).size.width / 2 - 30,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.deepOrange,
              ),
              child: Center(
                  child: Text(
                "To $content",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              )),
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () async {
              HapticFeedback.mediumImpact();
              DynamicLinkParameters _parms = DynamicLinkParameters(
                uriPrefix: "https://tyger.page.link",
                link: Uri.parse(
                    "https://tyger.page.link/firebase/dynamicLinks/$content"),
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
              logger.e(_shortLink);
            },
            child: Container(
              width: MediaQueryData.fromWindow(window).size.width / 2 - 30,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.orange,
              ),
              child: Center(
                  child: Text(
                "Create $content",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
