import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class ClosedAppNativeScreen extends StatefulWidget {
  const ClosedAppNativeScreen({super.key});

  @override
  State<ClosedAppNativeScreen> createState() => _ClosedAppNativeScreenState();
}

class _ClosedAppNativeScreenState extends State<ClosedAppNativeScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> _spelling = [
      "A",
      "B",
      "C",
      "E",
      "F",
      "H",
      "J",
      "K",
      "L",
      "N",
      "O",
      "S",
      "V",
      "Z"
    ]..shuffle();

    ValueNotifier<String> _callName = ValueNotifier<String>("");
    MethodChannel _closedChannel = const MethodChannel("tyger/closed");
    return Scaffold(
      appBar: appBar(title: "Closed App With Native"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Text(
                  Platform.isIOS ? "IOS" : "Android",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 120),
                ValueListenableBuilder<String>(
                    valueListenable: _callName,
                    builder: (context, value, child) {
                      return Text(
                        value.isEmpty ? "Call Method Name" : value,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: value.isEmpty ? Colors.green : Colors.amber,
                            fontSize: 30),
                      );
                    })
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 10,
                runSpacing: 12,
                children: [
                  ..._spelling.map((e) => _button(
                      content: e,
                      onTap: (v) {
                        HapticFeedback.mediumImpact();
                        _callName.value = _callName.value + v!;
                      })),
                  _button(
                      icon: Icons.remove,
                      onTap: (v) {
                        HapticFeedback.mediumImpact();
                        _callName.value = "";
                      }),
                  _button(
                      icon: Icons.done_outlined,
                      color: Colors.green,
                      onTap: (v) async {
                        HapticFeedback.mediumImpact();
                        String? _result = await _closedChannel
                            .invokeMethod(_callName.value.toLowerCase());
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(_result ?? "Closed App")));
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _button({
    String? content,
    IconData? icon,
    Color? color,
    required Function(String?) onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(content),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color ?? const Color.fromRGBO(71, 71, 71, 1),
          ),
          width: (MediaQuery.of(context).size.width / 4) - (70 / 4),
          height: 50,
          child: Center(
              child: content == null
                  ? Icon(icon)
                  : Text(
                      content,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ))),
    );
  }
}
