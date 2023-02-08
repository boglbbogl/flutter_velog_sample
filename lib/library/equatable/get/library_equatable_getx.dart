import 'package:get/get.dart';

class LibraryEquatableGetx extends GetxController {
  int count = 0;

  void increment() {
    count = count + 1;
    update();
  }

  void stateReturn() {
    count;
    update();
  }

  @override
  void onInit() {
    count = 0;
    super.onInit();
  }
}
