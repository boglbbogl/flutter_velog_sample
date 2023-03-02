import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_size.dart';
import 'package:flutter_velog_sample/main_provider.dart';
import 'package:provider/provider.dart';

void authPhoneSheet(BuildContext context) {
  ValueNotifier<String> _number = ValueNotifier<String>("");
  ValueNotifier<int> _type = ValueNotifier<int>(0);
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color.fromRGBO(71, 71, 71, 1),
          child: SafeArea(
            child: Container(
              height: size.height * 0.6,
              width: size.width,
              color: const Color.fromRGBO(71, 71, 71, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                      valueListenable: _type,
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Text(
                            value == 0 ? "Phone Number" : "SMS Code",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        );
                      }),
                  ValueListenableBuilder<String>(
                      valueListenable: _number,
                      builder: (context, value, child) {
                        return SizedBox(
                            width: size.width,
                            height: 60,
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 48,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      }),
                  _numberForm(
                      type: _type.value,
                      onTap: (i) {
                        HapticFeedback.mediumImpact();
                        if ((_type.value == 0 && _number.value.length < 11) ||
                            (_type.value == 1 && _number.value.length < 6)) {
                          _number.value = "${_number.value}$i";
                        }
                      },
                      onSubmitted: () {
                        if (_type.value == 0 && _number.value.length == 11) {
                          context
                              .read<MainProvider>()
                              .signInWithPhoneNumber(context, _number.value);
                          _type.value = 1;
                          _number.value = "";
                        } else if (_type.value == 1 &&
                            _number.value.length == 6) {
                          context
                              .read<MainProvider>()
                              .signInWithSmsCode(context, _number.value);
                        }
                      },
                      onClearTap: () {
                        HapticFeedback.mediumImpact();
                        _number.value = "";
                      }),
                ],
              ),
            ),
          ),
        );
      });
}

Padding _numberForm({
  required int type,
  required Function(int) onTap,
  required Function() onClearTap,
  required Function() onSubmitted,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onClearTap,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromRGBO(91, 91, 91, 1),
                        ),
                        height: 60,
                        width: 100,
                        child: const Center(
                            child: Text(
                          "Clear",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                              fontSize: 18),
                        ))),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: onSubmitted,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.cyan,
                        ),
                        height: 60,
                        width: 60,
                        child: const Center(
                            child: Text(
                          "Done",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(71, 71, 71, 1),
                              fontSize: 18),
                        ))),
                  ),
                ],
              ),
            ),
          ],
        ),
        ...List.generate(
          2,
          (i) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Wrap(
              spacing: 10,
              children: [
                ...List.generate(
                  5,
                  (index) => GestureDetector(
                    onTap: () => onTap(i == 0 ? i + 5 + index : i * index),
                    child: Container(
                      width: size.width / 5 - (80 / 5),
                      height: size.width / 5 - (80 / 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.amber,
                      ),
                      child: Center(
                        child: Text(
                          i == 0 ? "${i + 5 + index}" : "${i * index}",
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(71, 71, 71, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
