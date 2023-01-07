import 'package:flutter/material.dart';

class InfinityScrollProvider extends ChangeNotifier {
  List<String> items = [];
  int currentIndex = 0;
  bool isMore = false;

  Future<void> pageViewItems({
    bool isStart = true,
  }) async {
    if (!isMore) {
      isMore = true;
      notifyListeners();
      Future.delayed(Duration(milliseconds: isStart ? 0 : 2000), () {
        for (int i = 0; i < 3; i++) {
          items
              .add('https://picsum.photos/id/${i + currentIndex + 50}/300/400');
        }
        currentIndex = currentIndex + 3;
        isMore = false;
        notifyListeners();
      });
    }
  }

  Future<void> changedPage(int index) async {
    if (index == currentIndex) {
      pageViewItems(isStart: false);
    }
  }

  Future<void> started() async {
    for (int i = 0; i < 20; i++) {
      items.add('https://picsum.photos/id/$i/200/200');
    }
    currentIndex = 20;
  }

  Future<void> _addItem() async {
    if (!isMore) {
      isMore = true;
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 3000), () {
        for (int i = 0; i < 20; i++) {
          items.add('https://picsum.photos/id/${i + currentIndex}/200/200');
        }
        currentIndex = currentIndex + 20;
        isMore = false;
        notifyListeners();
      });
    }
  }

  void listner(ScrollUpdateNotification notification) {
    if (notification.metrics.maxScrollExtent * 0.85 <
        notification.metrics.pixels) {
      _addItem();
    }
  }
}
