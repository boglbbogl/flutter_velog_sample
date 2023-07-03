import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class LocaleInformationScreen extends StatelessWidget {
  const LocaleInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Locale Information"),
      body: ListView(
        children: [
          const SizedBox(height: 12),
          _form(context, title: "DateTime", content: DateTime.now().toString()),
          _form(context,
              title: "DateTime(UTC)",
              content: DateTime.now().toUtc().toString()),
          _form(context,
              title: "TimeZone Name",
              content: DateTime.now().timeZoneName.toString()),
          _form(context,
              title: "TimeZone Offset",
              content: DateTime.now().timeZoneOffset.toString()),
          _form(context,
              title: "Launguage Code",
              content: Localizations.localeOf(context).languageCode),
          _form(context,
              title: "Country Code",
              content: Localizations.localeOf(context).countryCode.toString()),
        ],
      ),
    );
  }

  Padding _form(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 12),
      child: Row(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.28,
              child: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              )),
          Flexible(
            child: Text(
              content,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
