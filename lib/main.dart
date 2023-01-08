import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/core/app_theme.dart';
import 'package:flutter_velog_sample/count_app/count_screen_with_listenerable.dart';
import 'package:flutter_velog_sample/count_app/count_screen_with_stateful.dart';
import 'package:flutter_velog_sample/count_app/get/count_screen_with_get_reactive.dart';
import 'package:flutter_velog_sample/count_app/get/count_screen_with_get_simple.dart';
import 'package:flutter_velog_sample/count_app/provider/count_screen_with_provider.dart';
import 'package:flutter_velog_sample/infinity_scroll/horizontal_infinity_scroll_screen.dart';
import 'package:flutter_velog_sample/infinity_scroll/pageview_infinity_scroll_screen.dart';
import 'package:flutter_velog_sample/infinity_scroll/vertical_infinity_scroll_screen.dart';
import 'package:flutter_velog_sample/initial_app.dart';
import 'package:flutter_velog_sample/main_provider.dart';
import 'package:flutter_velog_sample/scroll_indicator/vertical_indicator/vertical_indicator_screen.dart';
import 'package:provider/provider.dart';

import 'scroll_indicator/horizontal_indicator/horizontal_indicator_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
      ],
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        home: const InitialApp(),
        routes: {
          '/count/app/stateFul': (context) => const CountScreenWithStateFul(),
          '/count/app/listenerable': (context) =>
              const CountScreenWithListenarable(),
          '/count/app/provider': (context) => const CountScreenWithProvider(),
          '/count/app/get/simple': (context) =>
              const CountScreenWithGetSimple(),
          '/count/app/get/reactive': (context) =>
              const CountScreenWithGetReactive(),
          '/scrollIndicator/vertical': (context) =>
              const VerticalIndicatorScreen(),
          '/scrollIndicator/horizontal': (context) =>
              const HorizontalIndicatorScreen(),
          '/infinityScroll/vertical': (context) =>
              const VerticalInfinityScrollScreen(),
          '/infinityScroll/horizontal': (context) =>
              const HorizontalInfinityScrollScreen(),
          '/infinityScroll/pageview': (context) =>
              const PageviewInfinityScrollScreen(),
        },
      ),
    );
  }
}
