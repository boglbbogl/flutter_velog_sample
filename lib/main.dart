import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as river;
import 'package:flutter_velog_sample/_core/app_theme.dart';
import 'package:flutter_velog_sample/app/calculator/app_calculator_screen.dart';
import 'package:flutter_velog_sample/count_app/bloc/count_screen_with_bloc.dart';
import 'package:flutter_velog_sample/count_app/count_screen_with_listenerable.dart';
import 'package:flutter_velog_sample/count_app/count_screen_with_stateful.dart';
import 'package:flutter_velog_sample/count_app/cubit/count_screen_with_cubit.dart';
import 'package:flutter_velog_sample/count_app/get/count_screen_with_get_reactive.dart';
import 'package:flutter_velog_sample/count_app/get/count_screen_with_get_simple.dart';
import 'package:flutter_velog_sample/count_app/mobx/count_screen_with_mobx.dart';
import 'package:flutter_velog_sample/count_app/provider/count_screen_with_provider.dart';
import 'package:flutter_velog_sample/count_app/count_screen_with_riverpod.dart';
import 'package:flutter_velog_sample/infinity_scroll/horizontal_infinity_scroll_screen.dart';
import 'package:flutter_velog_sample/infinity_scroll/pageview_infinity_scroll_screen.dart';
import 'package:flutter_velog_sample/infinity_scroll/vertical_infinity_scroll_screen.dart';
import 'package:flutter_velog_sample/initial_app.dart';
import 'package:flutter_velog_sample/library/equatable/library_equatable_screen.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_native_provider.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_screen_with_getx.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_screen_with_native.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_screen_with_statful.dart';
import 'package:flutter_velog_sample/main_provider.dart';
import 'package:flutter_velog_sample/scroll_indicator/vertical_indicator/vertical_indicator_screen.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_view_with_custom_scroll_screen.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_view_with_gesture_to_scroll_screen.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_view_with_list_view_screen.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_view_with_single_child_screen.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_view_with_view_and_builder_screen.dart';
import 'package:flutter_velog_sample/tab_view/custom/tab_view_custom_screen.dart';
import 'package:flutter_velog_sample/tab_view/pageview/tab_view_page_view_screen.dart';
import 'package:flutter_velog_sample/tab_view/tabbar/tab_view_tabbar_screen.dart';
import 'package:flutter_velog_sample/ui/sns_ui_heart_icon_screen.dart';
import 'package:flutter_velog_sample/ui/sns_ui_heart_motion_screen.dart';
import 'package:flutter_velog_sample/webview/webview_with_inapp_channel_screen.dart';
import 'package:flutter_velog_sample/webview/webview_with_inapp_screen.dart';
import 'package:flutter_velog_sample/webview/webview_with_launcher_screen.dart';
import 'package:flutter_velog_sample/webview/webview_with_swift_ui_webview_screen.dart';
import 'package:flutter_velog_sample/webview/webview_with_swift_wkwebview_screen.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'scroll_indicator/horizontal_indicator/horizontal_indicator_screen.dart';

Logger logger = Logger();

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
        ChangeNotifierProvider(
            create: ((context) => LifeCycleNativeProvider())),
      ],
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        home: const InitialApp(),
        routes: {
          'app/caculator': ((context) => const AppCaculatorScreen()),
          '/count/app/stateFul': (context) => const CountScreenWithStateFul(),
          '/count/app/listenerable': (context) =>
              const CountScreenWithListenarable(),
          '/count/app/provider': (context) => const CountScreenWithProvider(),
          '/count/app/get/simple': (context) =>
              const CountScreenWithGetSimple(),
          '/count/app/get/reactive': (context) =>
              const CountScreenWithGetReactive(),
          '/count/app/bloc': (context) => const CountScreenWithBloc(),
          '/count/app/cubit': (context) => const CountScreenWithCubit(),
          '/count/app/riverpod': (context) =>
              river.ProviderScope(child: CountScreenWithRiverpod()),
          '/count/app/mobx': (context) => const CountScreenWithMobx(),
          '/ui/sns/heart/icon': (context) => const SnsUIHeartIconScreen(),
          '/ui/sns/heart/motion': (context) => const SnsUIHeartMotionScreen(),
          '/tabview/tabbar': (context) => const TabViewTabbarScreen(),
          '/tabview/pageView': (context) => const TabViewPageViewScreen(),
          '/tabview/custom': (context) => const TabViewCustomScreen(),
          '/scroll/view/single': (context) =>
              const ScrollViewWithSingleChildScreen(),
          '/scroll/view/custom': (context) =>
              const ScrollViewWithCustomScrollScreen(),
          '/scroll/view/list/view': (context) =>
              const ScrollViewWithListViewScreen(),
          '/scroll/view/gestureToScroll': (context) =>
              const ScrollViewWithGestureToScrollScreen(),
          '/scroll/view/viewAndBuilder': (context) =>
              const ScrollViewWithViewAndBuilderScreen(),
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
          '/webview/inapp': (context) => const WebviewWithInappScreen(),
          '/webview/webviewFlutter': (context) =>
              const WebviewWithInappScreen(),
          '/webview/launcher': (context) => const WebviewWithLauncherScreen(),
          '/webview/swift/uiWebview': (context) =>
              const WebviewWithSwiftUiWebviewScreen(),
          '/webview/swift/wkWebview': (context) =>
              const WebviewWithSwiftWKWebviewScreen(),
          '/webview/inapp/channel': ((context) =>
              const WebviewWithInappChannelScreen()),
          '/lifeCycle/getx': (context) => const LifeCycleScreenWithGetx(),
          '/lifeCycle/stateful': (context) =>
              const LifeCycleScreenWithStateful(),
          '/lifeCycle/native': (context) => const LifeCycleScreenWithNative(),
          '/library/equatable': (context) => const LibraryEquatableScreen(),
        },
      ),
    );
  }
}
