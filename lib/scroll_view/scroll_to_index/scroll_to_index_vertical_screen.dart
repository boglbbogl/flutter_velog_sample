import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class ScrollToIndexVerticalScreen extends StatelessWidget {
  const ScrollToIndexVerticalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<GlobalKey> _globalKeys = List.generate(100, (index) => GlobalKey());
    int _currentIndex = 0;
    return Scaffold(
      appBar: appBar(title: "Vertical Scroll To Index"),
      floatingActionButton: SizedBox(
        height: 120,
        child: Column(
          children: [
            _button(
                onTap: () {
                  if (_currentIndex > 0) {
                    HapticFeedback.mediumImpact();
                    _currentIndex = _currentIndex - 1;
                    Scrollable.ensureVisible(
                        _globalKeys[_currentIndex].currentContext!,
                        alignment: 0,
                        duration: const Duration(milliseconds: 350));
                  }
                },
                icon: Icons.keyboard_arrow_up_outlined),
            const SizedBox(height: 12),
            _button(
                onTap: () {
                  if (_currentIndex < 99) {
                    HapticFeedback.mediumImpact();
                    _currentIndex = _currentIndex + 1;
                    Scrollable.ensureVisible(
                        _globalKeys[_currentIndex].currentContext!,
                        alignment: 0,
                        duration: const Duration(milliseconds: 350));
                  }
                },
                icon: Icons.keyboard_arrow_down_outlined),
          ],
        ),
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ...List.generate(
            100,
            (index) => Padding(
              key: _globalKeys[index],
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(31, 31, 31, 1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.accents[index % 15],
                    )),
                child: Center(
                  child: Text(
                    "$index",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.accents[index & 15]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector _button({
    required Function() onTap,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Icon(
          icon,
          color: Colors.black,
          size: 40,
        ),
      ),
    );
  }
}
