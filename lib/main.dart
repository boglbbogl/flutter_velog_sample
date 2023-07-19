import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as river;
import 'package:flutter_velog_sample/_core/app_theme.dart';
import 'package:flutter_velog_sample/app/address/presentation/app_address_screen.dart';
import 'package:flutter_velog_sample/app/calander/presentation/app_calander_screen.dart';
import 'package:flutter_velog_sample/app/calculator/app_calculator_screen.dart';
import 'package:flutter_velog_sample/app/color_picker/app_color_picker_screen.dart';
import 'package:flutter_velog_sample/app/date_picker/app_date_picker_screen.dart';
import 'package:flutter_velog_sample/app/search/filter/presentation/search_filter_screen.dart';
import 'package:flutter_velog_sample/app/stopwatch/app_stopwatch_screen.dart';
import 'package:flutter_velog_sample/app/time_line/presentation/app_time_line_screen.dart';
import 'package:flutter_velog_sample/closed_app/closed_app_flutter_screen.dart';
import 'package:flutter_velog_sample/closed_app/closed_app_native_screen.dart';
import 'package:flutter_velog_sample/count_app/bloc/count_screen_with_bloc.dart';
import 'package:flutter_velog_sample/count_app/count_screen_with_listenerable.dart';
import 'package:flutter_velog_sample/count_app/count_screen_with_stateful.dart';
import 'package:flutter_velog_sample/count_app/cubit/count_screen_with_cubit.dart';
import 'package:flutter_velog_sample/count_app/get/count_screen_with_get_reactive.dart';
import 'package:flutter_velog_sample/count_app/get/count_screen_with_get_simple.dart';
import 'package:flutter_velog_sample/count_app/mobx/count_screen_with_mobx.dart';
import 'package:flutter_velog_sample/count_app/provider/count_screen_with_provider.dart';
import 'package:flutter_velog_sample/count_app/count_screen_with_riverpod.dart';
import 'package:flutter_velog_sample/custom_painter/bubble_chat/painter_bubble_chat_screen.dart';
import 'package:flutter_velog_sample/custom_painter/chart/painter_pie_chart_screen.dart';
import 'package:flutter_velog_sample/custom_painter/chart/painter_animation_pie_chart_screen.dart';
import 'package:flutter_velog_sample/custom_painter/chart/painter_doughnut_chart_screen.dart';
import 'package:flutter_velog_sample/custom_painter/chart/painter_raidal_chart_screen.dart';
import 'package:flutter_velog_sample/custom_painter/watch/painter_apple_watch_screen.dart';
import 'package:flutter_velog_sample/dart_lang/factory/dart_pattern_screen_with_factory.dart';
import 'package:flutter_velog_sample/dart_lang/singleton/dart_pattern_screen_with_singleton.dart';
import 'package:flutter_velog_sample/firebase/analytics/firebase_analytics_screen.dart';
import 'package:flutter_velog_sample/firebase/authentication/presentation/firebase_authentication_screen.dart';
import 'package:flutter_velog_sample/firebase/dynamic_links/dynamic_links_first_screen.dart';
import 'package:flutter_velog_sample/firebase/dynamic_links/dynamic_links_provider.dart';
import 'package:flutter_velog_sample/firebase/dynamic_links/dynamic_links_second_screen.dart';
import 'package:flutter_velog_sample/firebase/dynamic_links/dynamic_links_third_screen.dart';
import 'package:flutter_velog_sample/firebase/dynamic_links/firebase_dynamic_links_screen.dart';
import 'package:flutter_velog_sample/firebase/fcm/cloud_message_provider.dart';
import 'package:flutter_velog_sample/firebase/fcm/firebase_message_screen.dart';
import 'package:flutter_velog_sample/firebase/firestore/firebase_firestore_screen.dart';
import 'package:flutter_velog_sample/firebase/realtime/firebase_realtime_screen.dart';
import 'package:flutter_velog_sample/firebase/storage/firebase_storage_screen.dart';
import 'package:flutter_velog_sample/firebase_options.dart';
import 'package:flutter_velog_sample/http/dio/http_with_dio_screen.dart';
import 'package:flutter_velog_sample/http/get_connect/http_with_get_connect_screen.dart';
import 'package:flutter_velog_sample/http/http/http_with_http_screen.dart';
import 'package:flutter_velog_sample/infinity_scroll/horizontal_infinity_scroll_screen.dart';
import 'package:flutter_velog_sample/infinity_scroll/pageview_infinity_scroll_screen.dart';
import 'package:flutter_velog_sample/infinity_scroll/vertical_infinity_scroll_screen.dart';
import 'package:flutter_velog_sample/information/locale_information_screen.dart';
import 'package:flutter_velog_sample/initial_app.dart';
import 'package:flutter_velog_sample/library/daum_postcode/library_daum_postcode_screen.dart';
import 'package:flutter_velog_sample/library/dio/library_dio_screen.dart';
import 'package:flutter_velog_sample/library/equatable/library_equatable_screen.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_native_provider.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_screen_with_getx.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_screen_with_native.dart';
import 'package:flutter_velog_sample/life_cycle/life_cycle_screen_with_statful.dart';
import 'package:flutter_velog_sample/management/changed_image/presentation/changed_image_cubit_screen.dart';
import 'package:flutter_velog_sample/management/infinity_image/presentation/infinity_image_bloc_screen.dart';
import 'package:flutter_velog_sample/management/text_listener/screen/text_listener_screen.dart';
import 'package:flutter_velog_sample/performance/tabview/performance_tabview_screen.dart';
import 'package:flutter_velog_sample/platform_channel/battery_level/platform_battery_screen.dart';
import 'package:flutter_velog_sample/platform_channel/count/platform_count_screen.dart';
import 'package:flutter_velog_sample/scroll_indicator/vertical_indicator/vertical_indicator_screen.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_to_index/scroll_to_index_horizontal_screen.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_to_index/scroll_to_index_vertical_screen.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_view_with_custom_scroll_screen.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_view_with_gesture_to_scroll_screen.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_view_with_list_view_screen.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_view_with_single_child_screen.dart';
import 'package:flutter_velog_sample/scroll_view/scroll_view_with_view_and_builder_screen.dart';
import 'package:flutter_velog_sample/tab_view/custom/tab_view_custom_screen.dart';
import 'package:flutter_velog_sample/tab_view/pageview/tab_view_page_view_screen.dart';
import 'package:flutter_velog_sample/tab_view/tabbar/tab_view_tabbar_screen.dart';
import 'package:flutter_velog_sample/ui/heart_motion/sns_ui_heart_icon_screen.dart';
import 'package:flutter_velog_sample/ui/heart_motion/sns_ui_heart_motion_screen.dart';
import 'package:flutter_velog_sample/ui/images/network_image_screen.dart';
import 'package:flutter_velog_sample/ui/slider/flexible/flexible_slider_ui_screen.dart';
import 'package:flutter_velog_sample/ui/slider/over_image/over_image_ui_screen.dart';
import 'package:flutter_velog_sample/webview/webview_with_inapp_screen.dart';
import 'package:flutter_velog_sample/webview/webview_with_launcher_screen.dart';
import 'package:flutter_velog_sample/webview/webview_with_swift_ui_webview_screen.dart';
import 'package:flutter_velog_sample/webview/webview_with_swift_wkwebview_screen.dart';
import 'package:flutter_velog_sample/webview/webview_with_webview_flutter_screen.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'scroll_indicator/horizontal_indicator/horizontal_indicator_screen.dart';
import 'webview/daum_post/webview_with_daum_post_screen.dart';
import 'dart:developer' as dev;

Logger logger = Logger();

Future<void> _onBackgroundMessage(RemoteMessage message) async {}

class Observer extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    if (kDebugMode) {
      String _default = "Created BLoC";
      dev.log('\x1B[37m$_default $bloc\x1B[0m');
    }
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    if (kDebugMode) {
      String _default = "Closed BLoC";
      dev.log('\x1B[32m$_default $bloc\x1B[0m');
    }
    super.onClose(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  Bloc.observer = Observer();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: ((context) => LifeCycleNativeProvider())),
        ChangeNotifierProvider(create: (context) => DynamicLinksProvider()),
        ChangeNotifierProvider(create: (context) => CloudMessageProvider()),
      ],
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        home: const InitialApp(),
        routes: {
          "/app/caculator": (context) => const AppCaculatorScreen(),
          "/app/color/picker": (context) => const AppColorPickerScreen(),
          "/app/date/picker": (context) => const AppDatePickerScreen(),
          "/app/calander": (context) => const AppCalanderScreen(),
          "/app/stopwatch": (context) => const AppStopWatchScreen(),
          "/app/address": (context) => const AppAddressScreen(),
          "/app/search/filter": (context) => const AppSearchFilterScreen(),
          "/app/time/line": (context) => const AppTimeLineScreen(),
          "/firebase/authentication": (context) =>
              const FirebaseAuthenticationScreen(),
          "/firebase/firestore": (context) => const FirebaseFirestoreScreen(),
          "/firebase/realtime": (context) => const FirebaseRealtimeScreen(),
          "/firebase/storage": (context) => const FirebaseStorageScreen(),
          "/firebase/dynamicLinks": (context) =>
              const FirebaseDynamicLinksScreen(),
          "/firebase/dynamicLinks/first": (context) =>
              const DynamicLinksFirstScreen(),
          "/firebase/dynamicLinks/second": (context) =>
              const DynamicLinksSecondScreen(),
          "/firebase/dynamicLinks/third": (context) =>
              const DynamicLinksThirdScreen(),
          "/firebase/messaging": (context) => const FirebaseMessageScreen(),
          "/firebase/analytics": (context) => const FirebaseAnalyticsScreen(),
          "/information/locale": (context) => const LocaleInformationScreen(),
          "/performance/tabview": (context) => const PerformanceTabViewScreen(),
          "/custom/painter/bubble/chat": (context) =>
              const PainterBubbleChatScreen(),
          "/custom/painter/apple/watch": (context) =>
              const PainterAppleWatchScreen(),
          "/custom/painter/pie/chart": (context) =>
              const PainterPieChatScreen(),
          "/custom/painter/animation/pie/chart": (context) =>
              const PainterAnimationPieChartScreen(),
          "/custom/painter/radial/chart": (context) =>
              const PainterRadialChartScreen(),
          "/custom/painter/doughnut/chart": (context) =>
              const PainterDoughnutChartScreen(),
          "/platform/count": (context) => const PlatformCountScreen(),
          "/platform/battery": (context) => const PlatformBatteryScreen(),
          "/management/changed/image": (context) =>
              const ChangedImageCubitScreen(),
          "/management/infinity/image": (context) =>
              const InfinityImageBlocScreen(),
          "/management/text/listener": (context) => TextListenerScreen(),
          "/count/app/stateFul": (context) => const CountScreenWithStateFul(),
          "/count/app/listenerable": (context) =>
              const CountScreenWithListenarable(),
          "/count/app/provider": (context) => const CountScreenWithProvider(),
          "/count/app/get/simple": (context) =>
              const CountScreenWithGetSimple(),
          "/count/app/get/reactive": (context) =>
              const CountScreenWithGetReactive(),
          "/count/app/bloc": (context) => const CountScreenWithBloc(),
          "/count/app/cubit": (context) => const CountScreenWithCubit(),
          "/count/app/riverpod": (context) =>
              river.ProviderScope(child: CountScreenWithRiverpod()),
          "/count/app/mobx": (context) => const CountScreenWithMobx(),
          "/ui/sns/heart/icon": (context) => const SnsUIHeartIconScreen(),
          "/ui/sns/heart/motion": (context) => const SnsUIHeartMotionScreen(),
          "/ui/flexible/slider": (context) => const FlexibleSliderUIScreen(),
          "/ui/over/image/slider": (context) => const OverImageUIScreen(),
          "/ui/image/network": (context) => const NetworkImageScreen(),
          "/tabview/tabbar": (context) => const TabViewTabbarScreen(),
          "/tabview/pageView": (context) => const TabViewPageViewScreen(),
          "/tabview/custom": (context) => const TabViewCustomScreen(),
          "/scroll/view/single": (context) =>
              const ScrollViewWithSingleChildScreen(),
          "/scroll/view/custom": (context) =>
              const ScrollViewWithCustomScrollScreen(),
          "/scroll/view/list/view": (context) =>
              const ScrollViewWithListViewScreen(),
          "/scroll/view/gestureToScroll": (context) =>
              const ScrollViewWithGestureToScrollScreen(),
          "/scroll/view/viewAndBuilder": (context) =>
              const ScrollViewWithViewAndBuilderScreen(),
          "/scrollIndicator/vertical": (context) =>
              const VerticalIndicatorScreen(),
          "/scrollIndicator/horizontal": (context) =>
              const HorizontalIndicatorScreen(),
          "/scroll/to/horizontal": (context) =>
              const ScrollToIndexHorizontalScreen(),
          "/scroll/to/vertical": (context) =>
              const ScrollToIndexVerticalScreen(),
          "/infinityScroll/vertical": (context) =>
              const VerticalInfinityScrollScreen(),
          "/infinityScroll/horizontal": (context) =>
              const HorizontalInfinityScrollScreen(),
          "/infinityScroll/pageview": (context) =>
              const PageviewInfinityScrollScreen(),
          "/http/http": (context) => const HttpWithHttpScreen(),
          "/http/dio": (context) => const HttpWithDioScreen(),
          "/http/getConnect": (context) => const HttpWithGetConnectScreen(),
          '/webview/webviewFlutter': (context) =>
              const WebviewWithWebviewFlutterScreen(),
          "/webview/inapp": (context) => const WebviewWithInappScreen(),
          "/webview/launcher": (context) => const WebviewWithLauncherScreen(),
          "/webview/swift/uiWebview": (context) =>
              const WebviewWithSwiftUiWebviewScreen(),
          "/webview/swift/wkWebview": (context) =>
              const WebviewWithSwiftWKWebviewScreen(),
          "/webview/daumPost": (context) => const WebviewWithDaumPostScreen(),
          "/lifeCycle/getx": (context) => const LifeCycleScreenWithGetx(),
          "/lifeCycle/stateful": (context) =>
              const LifeCycleScreenWithStateful(),
          "/lifeCycle/native": (context) => const LifeCycleScreenWithNative(),
          "/closed/app/flutter": (context) => const ClosedAppFlutterScreen(),
          "/closed/app/native": (context) => const ClosedAppNativeScreen(),
          "/library/equatable": (context) => const LibraryEquatableScreen(),
          "/library/daumPostcode": (context) =>
              const LibararyDaumPostcodeScreen(),
          "/library/dio": ((context) => const LibraryDioScreen()),
          "/dart/pattern/singleton": (context) =>
              const DartPatternScreenWithSingleton(),
          "/dart/pattern/factory": (context) =>
              const DartPatternScreenWithFactory(),
        },
      ),
    );
  }
}
