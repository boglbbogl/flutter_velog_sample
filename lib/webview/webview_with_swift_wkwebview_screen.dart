import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class WebviewWithSwiftWKWebviewScreen extends StatelessWidget {
  const WebviewWithSwiftWKWebviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Webview With Swift(WKWebView)'),
      body: const UiKitView(
        viewType: 'plugins/swift/wkWebview',
        creationParamsCodec: StandardMessageCodec(),
      ),
    );
  }
}
