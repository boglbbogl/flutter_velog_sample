import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_size.dart';
import 'package:flutter_velog_sample/firebase/dynamic_links/dynamic_links_provider.dart';
import 'package:flutter_velog_sample/firebase/fcm/cloud_message_provider.dart';
import 'package:flutter_velog_sample/main_screen.dart';
import 'package:provider/provider.dart';

class InitialApp extends StatelessWidget {
  const InitialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    theme = Theme.of(context);
    context.watch<DynamicLinksProvider>().listener(context);
    context.watch<CloudMessageProvider>().listener(context);
    return const MainScreen();
  }
}
