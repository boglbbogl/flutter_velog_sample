import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class WebviewWithSwiftUiWebviewScreen extends StatelessWidget {
  const WebviewWithSwiftUiWebviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Webview With Swift(UiWebView)'),
      body: const UiKitView(
        viewType: 'plugins/swift/uiWebview',
        creationParamsCodec: StandardMessageCodec(),
      ),
    );
  }
}
