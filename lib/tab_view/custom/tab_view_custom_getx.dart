import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabViewCustomGetx extends GetxController {
  List<RxDouble> positions = [(0.0.obs), (Get.width).obs, (Get.width * 2).obs];
  RxInt duration = 0.obs;
  int tabIndex = 0;
  RxDouble indicatorPosition = 0.0.obs;

  void horizontalPanUpdated(DragUpdateDetails details) {
    duration.value = 0;
    positions[0].value = positions[0].value + details.delta.dx;
    positions[1].value = positions[1].value + details.delta.dx;
    positions[2].value = positions[2].value + details.delta.dx;
    indicatorPosition.value = indicatorPosition.value - (details.delta.dx / 3);
  }

  void horizontalPanEnded(DragEndDetails details) {
    duration.value = 300;
    double _first = _returnToPanEndDouble(details.velocity, positions[0]);
    double _third = _returnToPanEndDouble(details.velocity, positions[2]);
    List<RxDouble> _returnPositions = [
      0.0.obs,
      (Get.width).obs,
      (Get.width * 2).obs
    ];
    switch (tabIndex) {
      case 0:
        if (_first < -Get.width / 2) {
          positions = [(-Get.width).obs, 0.0.obs, Get.width.obs];
          tabIndex = 1;
          indicatorPosition.value = Get.width / 3;
        } else {
          positions = [0.0.obs, (Get.width).obs, (Get.width * 2).obs];
          tabIndex = 0;
          indicatorPosition.value = 0;
        }
        break;
      case 1:
        if (_first > -Get.width / 2) {
          positions = [0.0.obs, (Get.width).obs, (Get.width * 2).obs];
          tabIndex = 0;
          indicatorPosition.value = 0;
        } else if (_third < Get.width / 2) {
          positions = [(-Get.width * 2).obs, (-Get.width).obs, 0.0.obs];
          tabIndex = 2;
          indicatorPosition.value = Get.width - (Get.width / 3);
        } else {
          positions = [(-Get.width).obs, 0.0.obs, Get.width.obs];
          tabIndex = 1;
          indicatorPosition.value = Get.width / 3;
        }

        break;
      case 2:
        if (_third < Get.width / 2) {
          positions = [(-Get.width * 2).obs, (-Get.width).obs, 0.0.obs];
          tabIndex = 2;
          indicatorPosition.value = Get.width - (Get.width / 3);
        } else {
          positions = [(-Get.width).obs, 0.0.obs, Get.width.obs];
          tabIndex = 1;
          indicatorPosition.value = Get.width / 3;
        }
        break;
      default:
        _returnPositions = _returnPositions;
    }
    update();
  }

  double _returnToPanEndDouble(
    Velocity velocity,
    RxDouble position,
  ) {
    double _move = (velocity.pixelsPerSecond.distance / 200) + position.value;
    return _move;
  }

  void tabChanged(int index) {
    duration.value = 300;
    tabIndex = index;
    switch (index) {
      case 0:
        positions = [(0.0).obs, (Get.width).obs, (Get.width * 2).obs];
        indicatorPosition.value = 0.0;
        break;
      case 1:
        positions = [(-Get.width).obs, (0.0).obs, (Get.width).obs];
        indicatorPosition.value = Get.width / 3;
        break;
      case 2:
        positions = [(-Get.width * 2).obs, (-Get.width).obs, (0.0).obs];
        indicatorPosition.value = Get.width - (Get.width / 3);
        break;
      default:
    }
    update();
  }
}
