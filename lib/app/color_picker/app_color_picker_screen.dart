import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/color_picker/color_picker_provider.dart';
import 'package:provider/provider.dart';

class AppColorPickerScreen extends StatelessWidget {
  const AppColorPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ColorPickerProvider>(
      create: (_) => ColorPickerProvider()..colorChanged(3),
      child: Consumer<ColorPickerProvider>(builder: (context, state, child) {
        return Scaffold(
          appBar: appBar(title: "Color Picker"),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQueryData.fromWindow(window).size.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      state.currentColor
                          .toString()
                          .replaceAll("0xff", "")
                          .replaceAll("Color", "Hex"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: state.currentColor),
                    )),
                    const SizedBox(height: 24),
                    Center(
                        child: Text(
                      "RGB(${state.currentColor.red}, ${state.currentColor.green}, ${state.currentColor.blue}, ${state.currentColor.opacity.toInt()})",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: state.currentColor),
                    )),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
                child: SizedBox(
                  height: 55,
                  child: Stack(
                    children: [
                      Center(
                        child: Wrap(
                          children: [
                            ...List.generate(
                              100,
                              (index) => GestureDetector(
                                onTap: () {
                                  state.pickerColorTap(
                                      state.pickerColors[index]);
                                },
                                child: Container(
                                    width: ((MediaQueryData.fromWindow(window)
                                                .size
                                                .width -
                                            60) /
                                        100),
                                    height: 40,
                                    color: state.pickerColors[index].color),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedPositioned(
                        duration: Duration(milliseconds: state.duration),
                        left: state.currentPosition,
                        child: GestureDetector(
                          onHorizontalDragStart: state.dragStart,
                          onHorizontalDragUpdate: state.dragUpdate,
                          child: Container(
                            width: 50,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(55),
                                color: state.currentColor,
                                border: Border.all(
                                    color: Colors.white70, width: 4)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ...List.generate(
                        state.colorList.length,
                        (index) => GestureDetector(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                state.colorChanged(index);
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white70, width: 3),
                                  color: state.colorList[index],
                                ),
                              ),
                            )),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
