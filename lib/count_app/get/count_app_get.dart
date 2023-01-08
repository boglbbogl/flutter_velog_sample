import 'package:get/get.dart';

class CountAppGet extends GetxController {
  int count = 0;
  int selectCount = 1;
  RxInt rxCount = 0.obs;
  RxInt rxSelectCount = 1.obs;

  void changedCount(int number) => rxSelectCount.value = number;
  void increment() => rxCount.value = rxCount.value + rxSelectCount.value;
  void decrement() => rxCount.value = rxCount.value - rxSelectCount.value;
  void reset() => rxCount.value = 0;

  void updated(bool? isAdd) {
    if (isAdd != null) {
      if (isAdd) {
        count = count + selectCount;
        update();
      } else {
        count = count - selectCount;
        update();
      }
    } else {
      count = 0;
      update();
    }
  }

  void selected(int number) {
    selectCount = number;
    update();
  }

  @override
  void onInit() {
    count = 0;
    selectCount = 1;
    super.onInit();
  }
}
