import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class ScrollViewWithListViewScreen extends StatelessWidget {
  const ScrollViewWithListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Scroll View With ListView'),
      body: ListView(
        children: [
          ...List.generate(
              1000,
              (index) => Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "index : $index",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.accents[index % 15]),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
