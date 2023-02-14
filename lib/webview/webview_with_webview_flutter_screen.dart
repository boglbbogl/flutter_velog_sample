import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewWithWebviewFlutterScreen extends StatefulWidget {
  const WebviewWithWebviewFlutterScreen({super.key});

  @override
  State<WebviewWithWebviewFlutterScreen> createState() =>
      _WebviewWithWebviewFlutterScreenState();
}

class _WebviewWithWebviewFlutterScreenState
    extends State<WebviewWithWebviewFlutterScreen> {
  WebViewController? _webViewController;
  @override
  void initState() {
    _webViewController = WebViewController()
      ..loadRequest(Uri.parse('https://youtube.com'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'WebView With WebView Flutter'),
      body: WebViewWidget(controller: _webViewController!),
    );
  }
}
