import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/firebase/dynamic_links/dynamic_links_provider.dart';
import 'package:provider/provider.dart';

class FirebaseDynamicLinksScreen extends StatelessWidget {
  const FirebaseDynamicLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Firebase Dynamic Links"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button(
            context: context,
            content: "first",
          ),
          _button(
            context: context,
            content: "second",
          ),
          _button(
            context: context,
            content: "third",
          ),
        ],
      ),
    );
  }

  Padding _button({
    required BuildContext context,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).pushNamed("firebase/dynamicLinks/$content");
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 30,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.deepOrange,
              ),
              child: Center(
                  child: Text(
                "To $content",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              )),
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () async {
              context
                  .read<DynamicLinksProvider>()
                  .createDynamicLink(context, content);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 30,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.orange,
              ),
              child: Center(
                  child: Text(
                "Create $content",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
