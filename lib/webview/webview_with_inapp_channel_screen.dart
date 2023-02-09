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
                    // print("StartInAppWebview :$arguments");
                  }));
            }),
            onConsoleMessage: (controller, consoleMessage) {
              // print("ConsolMessage :: ${consoleMessage.message}");
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
                    // print("loadStopReturn :$arguments");
                  }));
            }),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Wrap(
                children: [
                  _buttonForm(
                      color: Colors.red,
                      onTap: () {
                        _controller.evaluateJavascript(source: """ 
                const button1 = new CustomEvent("Button1", { 
                   detail: {button : "test"}
                 }); 
                window.dispatchEvent(button1); 
                """);
                      }),
                  _buttonForm(
                      color: Colors.green,
                      onTap: () {
                        // Map<String, dynamic> _person =
                        //     const PersonTest("Tyger", 100).toMap();
                        _controller.evaluateJavascript(source: """ 
                const button2 = new CustomEvent("Button2", { 
                   detail: {button : "test"}
                 }); 
                window.dispatchEvent(button2); 
                """);
                      }),
                  _buttonForm(color: Colors.amber, onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _buttonForm({
    required Color color,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width / 3,
        color: color,
      ),
    );
  }
}

class PersonTest {
  final String name;
  final int age;
  const PersonTest(this.name, this.age);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "age": age,
    };
  }
}
