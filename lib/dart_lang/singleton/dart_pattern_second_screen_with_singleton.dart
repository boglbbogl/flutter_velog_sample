import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/dart_lang/singleton/singleton_example_model.dart';

class DartPatternSecondScreenWithSingleton extends StatelessWidget {
  const DartPatternSecondScreenWithSingleton({super.key});

  @override
  Widget build(BuildContext context) {
    SingletonExampleModel _singletonModel = SingletonExampleModel();
    return Scaffold(
      appBar: appBar(title: "Singleton Second Page"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _form(context, _singletonModel.title, "Title : "),
          const SizedBox(height: 24),
          _form(context, "${_singletonModel.count}", "Count : "),
        ],
      ),
    );
  }

  SizedBox _form(BuildContext context, String content, String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            content,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.amber),
          ),
        ],
      ),
    );
  }
}
