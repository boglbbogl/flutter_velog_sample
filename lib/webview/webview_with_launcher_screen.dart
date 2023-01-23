import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebviewWithLauncherScreen extends StatelessWidget {
  const WebviewWithLauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String _url = 'https://youtube.com';
    return Scaffold(
      appBar: appBar(title: 'WebView With Launcher'),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _button(
              context: context,
              title: 'In App Webview',
              onTap: () async {
                if (await canLaunchUrlString(_url)) {
                  await launchUrlString(_url);
                }
              },
            ),
            const SizedBox(height: 48),
            _button(
              context: context,
              title: 'Out App Webview',
              onTap: () async {
                if (await canLaunchUrlString(_url)) {
                  await launchUrlString(_url,
                      mode: LaunchMode.externalApplication);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _button({
    required BuildContext context,
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromRGBO(135, 135, 135, 1),
          ),
          child: Center(
              child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ))),
    );
  }
}
