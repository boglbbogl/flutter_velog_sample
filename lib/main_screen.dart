import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_size.dart';
import 'package:flutter_velog_sample/main_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('START !!');
    return Consumer<MainProvider>(builder: (context, value, child) {
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
                  length: 2,
                  isCreated: false,
                  context: context,
                  content: 'Timer',
                  namedRouter: '',
                ),
                _item(
                  length: 2,
                  isCreated: false,
                  context: context,
                  content: 'Calculator',
                  namedRouter: '',
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
              _category(title: 'Tab View', widgets: [
                _item(
                  length: 3,
                  context: context,
                  content: 'Tabbar View',
                  namedRouter: '/tabview/tabbar',
                ),
                _item(
                  isCreated: false,
                  length: 3,
                  context: context,
                  content: 'Page View',
                  namedRouter: '/tabview/pageView',
                ),
                _item(
                  isCreated: false,
                  length: 3,
                  context: context,
                  content: 'Custom View',
                  namedRouter: '/tabview/custom',
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
              _category(title: 'Webview', widgets: [
                _item(
                  isCreated: false,
                  context: context,
                  content: 'WebviewFlutter',
                  namedRouter: '',
                ),
                _item(
                  isCreated: false,
                  context: context,
                  content: 'Launcher',
                  namedRouter: '',
                ),
                _item(
                  isCreated: false,
                  context: context,
                  content: 'InAppWebview',
                  namedRouter: '',
                ),
                _item(
                  isCreated: false,
                  context: context,
                  content: 'InApp..(Launcher)',
                  namedRouter: '',
                ),
              ]),
              _category(title: 'Data Type', widgets: [
                _item(
                  isCreated: false,
                  context: context,
                  content: 'Freezed',
                  namedRouter: '',
                ),
                _item(
                  isCreated: false,
                  context: context,
                  content: 'Dartz',
                  namedRouter: '',
                ),
              ]),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    });
  }

  IgnorePointer _item({
    required BuildContext context,
    required String content,
    required String namedRouter,
    int length = 2,
    bool isCreated = true,
  }) {
    return IgnorePointer(
      ignoring: !isCreated,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(namedRouter);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            width: length == 2
                ? (size.width / 2) - (50 / 2)
                : length == 3
                    ? (size.width / 3) - (60 / 3)
                    : (size.width / 3) - (60 / 3),
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isCreated
                  ? const Color.fromRGBO(125, 125, 125, 1)
                  : const Color.fromRGBO(61, 61, 61, 1),
            ),
            child: Center(
              child: Text(
                content,
                style: TextStyle(
                    fontSize: 14,
                    color: isCreated
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
            children: widgets,
          )
        ],
      ),
    );
  }
}
