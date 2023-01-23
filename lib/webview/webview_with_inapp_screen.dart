import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class WebviewWithInappScreen extends StatelessWidget {
  const WebviewWithInappScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'WebView With In App WebView'),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse('https://youtube.com'),
        ),
        initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(useHybridComposition: true)),
      ),
    );
  }
}
