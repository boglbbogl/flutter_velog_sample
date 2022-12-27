import 'package:flutter/material.dart';

class VerticalIndicatorProvider extends ChangeNotifier {
  List<String> indexSample = [];
  List<Color> color = [];
  ScrollController scrollController = ScrollController();
  double deviceHeight = 0.0;
  bool isMoreLoading = false;
  double verticalPosition = 0.0;
  double verticalHeight = 0.0;

  void started({
    required BuildContext context,
  }) {
    deviceHeight = MediaQuery.of(context).size.height;
    indexSample = List.generate(15, (index) => 'Index $index');
    color = List.generate(15, (index) => Colors.accents[index]);
  }

  void _addItem() {
    if (!isMoreLoading) {
      isMoreLoading = true;
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 2000), () {
        int _last = int.parse(indexSample.last.replaceAll("Index ", ""));
        indexSample.addAll(
            [...List.generate(15, (index) => 'Index ${index + (_last + 1)}')]);
        color.addAll(List.generate(15, (index) => Colors.accents[index]));
        Future.delayed(const Duration(milliseconds: 100), () {
          _verticalIndicatorPosition();
        });
        isMoreLoading = false;
        notifyListeners();
      });
    }
  }

  void _verticalIndicatorPosition() {
    verticalHeight =
        (deviceHeight / scrollController.position.maxScrollExtent) *
            deviceHeight;
    double _currentPixels = scrollController.position.pixels;
    double _mainContainer = (scrollController.position.maxScrollExtent) /
        (deviceHeight - verticalHeight - 150);
    verticalPosition = _currentPixels / _mainContainer;
    notifyListeners();
  }

  void listener() {
    scrollController.addListener(() {
      double _pixels = scrollController.position.pixels;
      if (_pixels > scrollController.position.maxScrollExtent * 0.8) {
        _addItem();
      }
      _verticalIndicatorPosition();
    });
  }
}
