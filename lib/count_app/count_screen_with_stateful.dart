import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/core/app_bar.dart';

class CountScreenWithStateFul extends StatefulWidget {
  const CountScreenWithStateFul({super.key});

  @override
  State<CountScreenWithStateFul> createState() =>
      _CountScreenWithStateFulState();
}

class _CountScreenWithStateFulState extends State<CountScreenWithStateFul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Count App With State Ful'),
      body: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text(
                  '1',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              )),
        ],
      ),
    );
  }
}
