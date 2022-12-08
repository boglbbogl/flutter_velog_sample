import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/core/app_size.dart';
import 'package:flutter_velog_sample/main_screen.dart';

class InitialApp extends StatelessWidget {
  const InitialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    theme = Theme.of(context);

    return const MainScreen();
  }
}
