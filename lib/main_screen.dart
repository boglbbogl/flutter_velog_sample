import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_size.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tyger App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _category(title: 'App', widgets: [
              _item(
                context: context,
                content: 'Stopwatch',
                namedRouter: "/app/stopwatch",
              ),
              _item(
                context: context,
                content: 'Calculator',
                namedRouter: '/app/caculator',
              ),
              _item(
                context: context,
                content: 'Date Picker',
                namedRouter: "/app/date/picker",
              ),
              _item(
                context: context,
                content: 'Calander',
                namedRouter: "/app/calander",
              ),
              _item(
                context: context,
                content: "Color Picker",
                namedRouter: "/app/color/picker",
              ),
              _item(
                context: context,
                content: "Address",
                namedRouter: "/app/address",
              ),
              _item(
                context: context,
                content: "Search Filter",
                namedRouter: "/app/search/filter",
              ),
              _item(
                context: context,
                content: "Time Line",
                namedRouter: "/app/time/line",
              ),
            ]),
            _category(title: "Firebase", widgets: [
              _item(
                context: context,
                content: "Authentication",
                namedRouter: "/firebase/authentication",
              ),
              _item(
                context: context,
                content: "Dynamic Links",
                namedRouter: "/firebase/dynamicLinks",
              ),
              _item(
                length: 3,
                context: context,
                content: "Firestore",
                namedRouter: "/firebase/firestore",
              ),
              _item(
                length: 3,
                context: context,
                content: "Realtime",
                namedRouter: "/firebase/realtime",
              ),
              _item(
                length: 3,
                context: context,
                content: "Storage",
                namedRouter: "/firebase/storage",
              ),
              _item(
                length: 3,
                context: context,
                content: "FCM",
                namedRouter: "/firebase/messaging",
              ),
              _item(
                length: 3,
                context: context,
                content: "GA",
                namedRouter: "/firebase/analytics",
              ),
              _item(
                length: 3,
                context: context,
                content: "Crashlytics",
              ),
            ]),
            _category(title: "Information", widgets: [
              _item(
                context: context,
                content: "Locale",
                namedRouter: "/information/locale",
                isPost: true,
              ),
            ]),
            _category(title: "Performance", widgets: [
              _item(
                context: context,
                content: "TabView",
                namedRouter: "/performance/tabview",
              ),
            ]),
            _category(title: "Custom Painter", widgets: [
              _item(
                context: context,
                content: "Bubble Chat",
                namedRouter: "/custom/painter/bubble/chat",
                isPost: true,
              ),
              _item(
                context: context,
                content: "Apple Watch",
                namedRouter: "/custom/painter/apple/watch",
              ),
              _item(
                context: context,
                content: "Pie Chart",
                namedRouter: "/custom/painter/pie/chart",
              ),
              _item(
                context: context,
                content: "Animation Pie",
                namedRouter: "/custom/painter/animation/pie/chart",
              ),
              _item(
                context: context,
                content: "Radial Chart",
                namedRouter: "/custom/painter/radial/chart",
              ),
              _item(
                context: context,
                content: "doughnut Chart",
                namedRouter: "/custom/painter/doughnut/chart",
              ),
            ]),
            _category(title: "Platform Channel", widgets: [
              _item(
                context: context,
                content: "Count App",
                namedRouter: "/platform/count",
              ),
              _item(
                context: context,
                content: "Battery",
                namedRouter: "/platform/battery",
              ),
            ]),
            _category(title: "State Management", widgets: [
              _item(
                length: 3,
                context: context,
                content: "Changed Image",
                namedRouter: "/management/changed/image",
              ),
              _item(
                length: 3,
                context: context,
                content: "Infinity Image",
                namedRouter: "/management/infinity/image",
              ),
              _item(
                length: 3,
                context: context,
                content: "Text Listener",
                namedRouter: "/management/text/listener",
              ),
            ]),
            _category(title: 'State Management With Count App', widgets: [
              _item(
                length: 3,
                context: context,
                content: 'State Ful',
                namedRouter: '/count/app/stateFul',
              ),
              _item(
                length: 3,
                context: context,
                content: 'Listenerable',
                namedRouter: '/count/app/listenerable',
              ),
              _item(
                length: 3,
                context: context,
                content: 'Provider',
                namedRouter: '/count/app/provider',
              ),
              _item(
                length: 3,
                context: context,
                content: 'Get X(simple)',
                namedRouter: '/count/app/get/simple',
              ),
              _item(
                length: 3,
                context: context,
                content: 'Get X(Reactive)',
                namedRouter: '/count/app/get/reactive',
              ),
              _item(
                length: 3,
                context: context,
                content: 'BLoC',
                namedRouter: '/count/app/bloc',
              ),
              _item(
                length: 3,
                context: context,
                content: 'Cubit',
                namedRouter: '/count/app/cubit',
              ),
              _item(
                length: 3,
                context: context,
                content: 'Riverpod',
                namedRouter: '/count/app/riverpod',
              ),
              _item(
                length: 3,
                context: context,
                content: 'MobX',
                namedRouter: '/count/app/mobx',
              ),
            ]),
            _category(title: 'UI', widgets: [
              _item(
                context: context,
                content: 'SNS Heart Icon',
                namedRouter: '/ui/sns/heart/icon',
              ),
              _item(
                context: context,
                content: 'SNS Heart Motion',
                namedRouter: '/ui/sns/heart/motion',
              ),
              _item(
                context: context,
                content: "Flexible Slider",
                namedRouter: "/ui/flexible/slider",
              ),
              _item(
                context: context,
                content: "Over Image Slider",
                namedRouter: "/ui/over/image/slider",
              ),
              _item(
                context: context,
                content: "Network Image",
                namedRouter: "/ui/image/network",
              ),
            ]),
            _category(title: 'Tab View', widgets: [
              _item(
                length: 3,
                context: context,
                content: 'Tabbar View',
                namedRouter: '/tabview/tabbar',
              ),
              _item(
                length: 3,
                context: context,
                content: 'Page View',
                namedRouter: '/tabview/pageView',
              ),
              _item(
                length: 3,
                context: context,
                content: 'Custom View',
                namedRouter: '/tabview/custom',
              ),
            ]),
            _category(title: 'Scroll View', widgets: [
              _item(
                length: 3,
                context: context,
                content: 'Single Child',
                namedRouter: '/scroll/view/single',
              ),
              _item(
                length: 3,
                context: context,
                content: 'Custom Scroll',
                namedRouter: '/scroll/view/custom',
              ),
              _item(
                length: 3,
                context: context,
                content: 'List View',
                namedRouter: '/scroll/view/list/view',
              ),
              _item(
                context: context,
                content: 'Gesture To Scroll',
                namedRouter: '/scroll/view/gestureToScroll',
              ),
              _item(
                context: context,
                content: 'View vs Builder',
                namedRouter: '/scroll/view/viewAndBuilder',
              ),
              _item(
                context: context,
                content: "Scroll To Index (H)",
                namedRouter: "/scroll/to/horizontal",
              ),
              _item(
                context: context,
                content: "Scroll To Index (V)",
                namedRouter: "/scroll/to/vertical",
              ),
            ]),
            _category(title: 'Scroll Indicator', widgets: [
              _item(
                context: context,
                content: 'Vertical',
                namedRouter: '/scrollIndicator/vertical',
              ),
              _item(
                context: context,
                content: 'Horizontal',
                namedRouter: '/scrollIndicator/horizontal',
              ),
            ]),
            _category(title: 'Infinity Scroll', widgets: [
              _item(
                length: 3,
                context: context,
                content: 'Vertical',
                namedRouter: '/infinityScroll/vertical',
              ),
              _item(
                length: 3,
                context: context,
                content: 'Horizontal',
                namedRouter: '/infinityScroll/horizontal',
              ),
              _item(
                length: 3,
                context: context,
                content: 'PageView',
                namedRouter: '/infinityScroll/pageview',
              ),
            ]),
            _category(title: "HTTP", widgets: [
              _item(
                length: 3,
                context: context,
                content: "Http",
                namedRouter: "/http/http",
              ),
              _item(
                  length: 3,
                  context: context,
                  content: "Dio",
                  namedRouter: "/http/dio"),
              _item(
                  length: 3,
                  context: context,
                  content: "Get Connect",
                  namedRouter: "/http/getConnect"),
            ]),
            _category(title: "Kakao API", widgets: []),
            _category(title: "Naver API", widgets: []),
            _category(title: 'Webview', widgets: [
              _item(
                context: context,
                content: 'WebviewFlutter',
                namedRouter: '/webview/webviewFlutter',
              ),
              _item(
                context: context,
                content: 'InAppWebview',
                namedRouter: '/webview/inapp',
              ),
              _item(
                context: context,
                content: 'Launcher',
                namedRouter: '/webview/launcher',
              ),
              _item(
                context: context,
                content: 'DaumPost WebView',
                namedRouter: '/webview/daumPost',
              ),
              _item(
                context: context,
                content: 'Swift UiWebView',
                namedRouter: '/webview/swift/uiWebview',
              ),
              _item(
                context: context,
                content: 'Swift WkWebView',
                namedRouter: '/webview/swift/wkWebview',
              ),
            ]),
            _category(title: 'Life Cycle', widgets: [
              _item(
                length: 3,
                context: context,
                content: 'Get X',
                namedRouter: '/lifeCycle/getx',
              ),
              _item(
                length: 3,
                context: context,
                content: 'State ful',
                namedRouter: '/lifeCycle/stateful',
              ),
              _item(
                length: 3,
                context: context,
                content: 'Native',
                namedRouter: '/lifeCycle/native',
              ),
            ]),
            _category(title: "Closed App", widgets: [
              _item(
                context: context,
                content: "Flutter",
                namedRouter: "/closed/app/flutter",
              ),
              _item(
                context: context,
                content: "Native",
                namedRouter: "/closed/app/native",
              ),
            ]),
            _category(title: 'Library', widgets: [
              _item(
                length: 3,
                context: context,
                content: 'Freezed',
              ),
              _item(
                length: 3,
                context: context,
                content: 'Dartz',
              ),
              _item(
                length: 3,
                context: context,
                content: "Logger",
              ),
              _item(
                length: 3,
                context: context,
                content: 'Equatable',
                namedRouter: '/library/equatable',
              ),
              _item(
                length: 3,
                context: context,
                content: 'DaumPostCode',
                namedRouter: '/library/daumPostcode',
              ),
              _item(
                length: 3,
                context: context,
                content: "Dio",
                namedRouter: '/library/dio',
              ),
            ]),
            _category(title: "Dart", widgets: [
              _item(
                context: context,
                content: "Singleton Pattenr",
                namedRouter: "/dart/pattern/singleton",
              ),
              _item(
                context: context,
                content: "Factory Pattenr",
                namedRouter: "/dart/pattern/factory",
              ),
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  IgnorePointer _item({
    required BuildContext context,
    required String content,
    String? namedRouter,
    int length = 2,
    bool isPost = false,
  }) {
    return IgnorePointer(
      ignoring: namedRouter == null,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          if (namedRouter != null) {
            Navigator.of(context).pushNamed(namedRouter);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            width: length == 1
                ? size.width
                : length == 2
                    ? (size.width / 2) - (50 / 2)
                    : length == 3
                        ? (size.width / 3) - (60 / 3)
                        : size.width,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: namedRouter != null
                  ? (isPost
                      ? Colors.green
                      : const Color.fromRGBO(125, 125, 125, 1))
                  : const Color.fromRGBO(61, 61, 61, 1),
            ),
            child: Center(
              child: Text(
                content,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: namedRouter != null
                        ? const Color.fromRGBO(215, 215, 215, 1)
                        : const Color.fromRGBO(155, 155, 155, 1)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _category({
    required String title,
    required List<Widget> widgets,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: [...widgets],
          ),
        ],
      ),
    );
  }
}
