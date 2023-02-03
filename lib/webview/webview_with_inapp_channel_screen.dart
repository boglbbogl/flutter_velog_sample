import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewWithInappChannelScreen extends StatefulWidget {
  const WebviewWithInappChannelScreen({super.key});

  @override
  State<WebviewWithInappChannelScreen> createState() =>
      _WebviewWithInappChannelScreenState();
}

class _WebviewWithInappChannelScreenState
    extends State<WebviewWithInappChannelScreen> {
  late InAppWebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InAppWebView(
            initialFile: "assets/html/webview_example.html",
            onWebViewCreated: ((controller) {
              _controller = controller;
              _controller.addJavaScriptHandler(
                  handlerName: "startInAppWebview",
                  callback: ((arguments) {
                    print("StartInAppWebview :$arguments");
                  }));
            }),
            onConsoleMessage: (controller, consoleMessage) {
              print("ConsolMessage :: ${consoleMessage.message}");
            },
            onLoadStop: ((controller, url) async {
              _controller.addJavaScriptHandler(
                  handlerName: "loadStop",
                  callback: ((arguments) {
                    return {"Now": "${DateTime.now()}"};
                  }));
              _controller.addJavaScriptHandler(
                  handlerName: "loadStopReturn",
                  callback: ((arguments) {
                    print("loadStopReturn :$arguments");
                  }));
            }),
          ),
          GestureDetector(
            onTap: () async {
              _controller.evaluateJavascript(source: """ 
                const customEvent = new CustomEvent("myCustomEvent", { 
                   detail: {foo: 1, bar: false} 
                 }); 
                window.dispatchEvent(customEvent); 
                """);
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
