import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/app/color_picker/color_picker_model.dart';
import 'package:flutter_velog_sample/app/color_picker/color_picker_provider.dart';
import 'package:provider/provider.dart';

class AppColorPickerScreen extends StatelessWidget {
  const AppColorPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ColorPickerProvider>(
      create: (_) => ColorPickerProvider()..colorChanged(ColorType.red, 0),
      child: Consumer<ColorPickerProvider>(builder: (context, state, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                state.currentColor.withOpacity(1),
                state.currentColor.withOpacity(0.5),
                state.currentColor.withOpacity(0.3),
                state.currentColor.withOpacity(0.4),
                state.currentColor.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: kToolbarHeight + 56,
                  child: Column(
                    children: [
                      const SizedBox(height: kToolbarHeight),
                      SizedBox(
                        height: 56,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              child: SizedBox(
                                height: 56,
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Center(
                                        child: Icon(
                                            Icons.arrow_back_ios_new_outlined)),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                                child: Text("Color Picker",
                                    style: AppBarTheme.of(context)
                                        .titleTextStyle!
                                        .copyWith(fontSize: 20))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        state.currentColor
                            .toString()
                            .replaceAll("0xff", "")
                            .replaceAll("Color", "Hex"),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white),
                      )),
                      const SizedBox(height: 24),
                      Center(
                          child: Text(
                        "RGB(${state.currentColor.red}, ${state.currentColor.green}, ${state.currentColor.blue}, ${state.currentColor.opacity.toInt()})",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 60),
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
                                    width: ((MediaQuery.of(context).size.width -
                                            60) /
                                        100),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: state.pickerColors[index].color,
                                    ),
                                  ),
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
                    runSpacing: 20,
                    children: [
                      ...List.generate(
                          state.colorType.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                  state.colorChanged(
                                      state.colorType[index], index);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 6 -
                                      (90 / 5.99999),
                                  height:
                                      MediaQuery.of(context).size.width / 6 -
                                          (90 / 5.99999),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: state.currentIndex == index
                                            ? Colors.white
                                            : Colors.white30,
                                        width: state.currentIndex == index
                                            ? 3
                                            : 2),
                                    color: Color.fromRGBO(
                                        state.colorType[index].rgb[0],
                                        state.colorType[index].rgb[1],
                                        state.colorType[index].rgb[2],
                                        1),
                                  ),
                                ),
                              )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
