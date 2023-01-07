import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/core/app_size.dart';
import 'package:flutter_velog_sample/main_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
      );
    });
  }

  GestureDetector _item({
    required BuildContext context,
    required String content,
    required String namedRouter,
    int length = 2,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(namedRouter);
      },
      child: Container(
        width: length == 2
            ? (size.width / 2) - (50 / 2)
            : (size.width / 3) - (60 / 3),
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(125, 125, 125, 1),
        ),
        child: Center(
          child: Text(
            content,
            style: const TextStyle(
                fontSize: 14, color: Color.fromRGBO(215, 215, 215, 1)),
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
