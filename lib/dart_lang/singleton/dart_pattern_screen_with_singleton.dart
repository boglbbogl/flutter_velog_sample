import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/dart_lang/singleton/dart_pattern_second_screen_with_singleton.dart';
import 'package:flutter_velog_sample/dart_lang/singleton/singleton_example_model.dart';

class DartPatternScreenWithSingleton extends StatefulWidget {
  const DartPatternScreenWithSingleton({super.key});

  @override
  State<DartPatternScreenWithSingleton> createState() =>
      _DartPatternScreenWithSingletonState();
}

class _DartPatternScreenWithSingletonState
    extends State<DartPatternScreenWithSingleton> {
  GeneralExampleModel general1 = GeneralExampleModel();
  GeneralExampleModel general2 = GeneralExampleModel();
  GeneralExampleModel general3 = GeneralExampleModel();
  SingletonExampleModel singleton1 = SingletonExampleModel();
  SingletonExampleModel singleton2 = SingletonExampleModel();
  SingletonExampleModel singleton3 = SingletonExampleModel();

  @override
  void initState() {
    setState(() {
      general2.title = "General 2";
      singleton2.title = "Singleton 2";
      general3.title = "General 3";
      singleton3.title = "Singleton 3";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Singleton Pattern"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const DartPatternSecondScreenWithSingleton())),
        child: const Icon(Icons.keyboard_arrow_right_outlined),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 40),
          _form(
            title: general1.title,
            count: general1.count,
            hashCode: general1.hashCode,
            onTap: () {
              setState(() {
                general1.count = general1.count + 1;
              });
            },
          ),
          _form(
            title: general2.title,
            count: general2.count,
            hashCode: general2.hashCode,
            onTap: () {
              setState(() {
                general2.count = general2.count + 1;
              });
            },
          ),
          _form(
            title: general3.title,
            count: general3.count,
            hashCode: general3.hashCode,
            onTap: () {
              setState(() {
                general3.count = general3.count + 1;
              });
            },
          ),
          _form(
            title: singleton1.title,
            count: singleton1.count,
            hashCode: singleton1.hashCode,
            onTap: () {
              setState(() {
                singleton1.count = singleton1.count + 1;
              });
            },
          ),
          _form(
            title: singleton2.title,
            count: singleton2.count,
            hashCode: singleton2.hashCode,
            onTap: () {
              setState(() {
                singleton2.count = singleton2.count + 1;
              });
            },
          ),
          _form(
            title: singleton3.title,
            count: singleton3.count,
            hashCode: singleton3.hashCode,
            onTap: () {
              setState(() {
                singleton3.count = singleton3.count + 1;
              });
            },
          ),
        ],
      ),
    );
  }

  Padding _form({
    required String title,
    required int count,
    required int hashCode,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                "$hashCode",
                style: const TextStyle(fontSize: 12, color: Colors.cyan),
              ),
            ],
          ),
          Text(
            "$count",
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.amber),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.add_circle_outline,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
