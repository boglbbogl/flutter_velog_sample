import 'package:flutter/foundation.dart';

class SnsTagService {
  static SnsTagService instance = SnsTagService._internal();
  factory SnsTagService() => instance;

  SnsTagService._internal();

  static ValueNotifier<String> current = ValueNotifier("");
  static bool isBack = false;

  void chaged(String tag) => current.value = tag;

  void canceled(bool value) => isBack = value;
}
