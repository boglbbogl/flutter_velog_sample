import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/_core/app_size.dart';
import 'package:flutter_velog_sample/app/calculator/app_calculator_provider.dart';
import 'package:flutter_velog_sample/app/calculator/calculator_model.dart';
import 'package:provider/provider.dart';

class AppCaculatorScreen extends StatelessWidget {
  const AppCaculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppCalculatorProvider>(
      create: (_) => AppCalculatorProvider(),
      child: Consumer<AppCalculatorProvider>(builder: (context, state, child) {
        return Scaffold(
          appBar: appBar(title: "Caculator App"),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    (((size.width / 4) - 10 - (30 / 4)) * 4 + 64) -
                    (kToolbarHeight + MediaQuery.of(context).padding.top),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          reverse: true,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Wrap(
                                alignment: WrapAlignment.end,
                                children: [
                                  ...state.currentContents.map(
                                    (e) => Text(
                                      " $e",
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          color:
                                              Color.fromRGBO(195, 195, 195, 1)),
                                    ),
                                  )
                                ],
                              ),
                              // child:
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.result.toString(),
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ((size.width / 4) - 10 - (30 / 4)) * 4 + 54,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ...CalculatorModel.model.map((e) => _button(
                                onTap: () => state.changedButtonClicked(
                                    e.symbol, e.number),
                                data: e,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  GestureDetector _button({
    required Function() onTap,
    required CalculatorModel data,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: data.number == 0
            ? (size.width / 2) - 10 - (30 / 2)
            : (size.width / 4) - 10 - (30 / 4),
        height: (size.width / 4) - 10 - (30 / 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: data.symbol != null
              ? const Color.fromRGBO(119, 119, 223, 1)
              : const Color.fromRGBO(75, 75, 75, 1),
        ),
        child: Center(
            child:
                Text(data.symbol == null ? "${data.number}" : data.symbol ?? "",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ))),
      ),
    );
  }
}
