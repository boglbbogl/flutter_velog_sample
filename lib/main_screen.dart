import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/core/app_size.dart';
import 'package:flutter_velog_sample/main_provider.dart';
import 'package:flutter_velog_sample/scroll/horizontal_indicator/horizontal_indicator_screen.dart';
import 'package:flutter_velog_sample/scroll/vertical_indicator/vertical_indicator_screen.dart';
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
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Scroll',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const VerticalIndicatorScreen()));
                          },
                          child: Container(
                            width: (size.width / 2) - (50 / 2),
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromRGBO(125, 125, 125, 1),
                            ),
                            child: const Center(
                              child: Text(
                                'Vertical Indicator',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(215, 215, 215, 1)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const HorizontalIndicatorScreen()));
                          },
                          child: Container(
                            width: (size.width / 2) - (50 / 2),
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromRGBO(125, 125, 125, 1),
                            ),
                            child: const Center(
                              child: Text(
                                'Horizontal Indicator',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(215, 215, 215, 1)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
