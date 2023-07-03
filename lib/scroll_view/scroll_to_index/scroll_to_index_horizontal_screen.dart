import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class ScrollToIndexHorizontalScreen extends StatefulWidget {
  const ScrollToIndexHorizontalScreen({super.key});

  @override
  State<ScrollToIndexHorizontalScreen> createState() =>
      _ScrollToIndexHorizontalScreenState();
}

class _ScrollToIndexHorizontalScreenState
    extends State<ScrollToIndexHorizontalScreen> {
  final List<String> _words = [];
  List<GlobalKey> firstKeys = [];
  List<GlobalKey> secondKeys = [];
  List<GlobalKey> thirdKeys = [];
  final GlobalKey renderKey = GlobalKey();
  int currentIndex = 0;

  @override
  void initState() {
    firstKeys = List.generate(20, (index) => GlobalKey());
    secondKeys = List.generate(20, (index) => GlobalKey());
    thirdKeys = List.generate(20, (index) => GlobalKey());
    generateWordPairs().take(1000).forEach((e) {
      _words.add(e.asString);
    });

    super.initState();
  }

  Duration _duration() {
    return const Duration(milliseconds: 350);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Horizontal Scroll To Index "),
      body: Column(children: [
        _form(
          title: "GlobalKeys",
          alignment: 0.5,
          renderKey: null,
          globalkeys: firstKeys,
          onChanged: (i) {
            Scrollable.ensureVisible(firstKeys[i].currentContext!,
                alignment: 0.5, duration: _duration());
          },
          items: _words.sublist(0, 20),
        ),
        _form(
          title: "GlobalKeys",
          alignment: 0.2,
          color: Colors.green,
          renderKey: null,
          globalkeys: secondKeys,
          onChanged: (i) {
            Scrollable.ensureVisible(secondKeys[i].currentContext!,
                alignment: 0.2, duration: _duration());
          },
          items: _words.sublist(21, 40),
        ),
        _form(
          title: "GlobalKeys",
          alignment: 0.7,
          color: Colors.purple,
          renderKey: null,
          globalkeys: thirdKeys,
          onChanged: (i) {
            Scrollable.ensureVisible(thirdKeys[i].currentContext!,
                alignment: 0.7, duration: _duration());
          },
          items: _words.sublist(41, 60),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 16),
              child: DefaultTextStyle(
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("RenderKey"),
                    Text("Alignment ${0.5}"),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _words.sublist(61, 80).length,
                  itemBuilder: (context, index) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      final RenderBox renderBox = renderKey.currentContext!
                          .findRenderObject() as RenderBox;
                      Scrollable.of(renderKey.currentContext!)
                          .position
                          .ensureVisible(renderBox,
                              alignment: 0.5, duration: _duration());
                    });
                    return GestureDetector(
                      key: index == currentIndex ? renderKey : null,
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Center(
                                  child: Text(
                                _words.sublist(61, 80)[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ]),
    );
  }

  _form({
    required String title,
    required double alignment,
    required List<GlobalKey>? globalkeys,
    required GlobalKey? renderKey,
    required Function(int) onChanged,
    required List<String> items,
    Color color = Colors.amber,
  }) {
    return Column(
      key: renderKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 16),
          child: DefaultTextStyle(
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text("Alignment $alignment"),
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 70,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  key: globalkeys == null ? null : globalkeys[index],
                  onTap: () => onChanged(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: color,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(
                              child: Text(
                            items[index],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
