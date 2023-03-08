import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
}
