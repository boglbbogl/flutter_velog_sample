import 'package:mobx/mobx.dart';

part 'count_app_mobx.g.dart';

class CountAppMobx = _CountAppMobx with _$CountAppMobx;

abstract class _CountAppMobx with Store {
  @observable
  int count = 0;

  @observable
  int selectCount = 1;

  @action
  void increment() {
    count = count + selectCount;
  }

  @action
  void decrement() {
    count = count - selectCount;
  }

  @action
  void reset() {
    count = 0;
  }

  @action
  void select(int number) {
    selectCount = number;
  }
}
