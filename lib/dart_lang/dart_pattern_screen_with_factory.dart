import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/main.dart';

class DartPatternScreenWithFactory extends StatefulWidget {
  const DartPatternScreenWithFactory({super.key});

  @override
  State<DartPatternScreenWithFactory> createState() =>
      _DartPatternScreenWithFactoryState();
}

class _DartPatternScreenWithFactoryState
    extends State<DartPatternScreenWithFactory> {
  bool isAndroid = false;
  bool isIOS = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Factory Pattern"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Text(
              "Platform Button",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PlatformButton(PlatformTarget.android).build(() {
                logger.e("Android Button !!");
              },
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    color: Colors.amber,
                    child: const Center(
                      child: Text(
                        'Android Button',
                      ),
                    ),
                  )),
              PlatformButton(PlatformTarget.ios).build(() {
                logger.e("IOS Button !!");
              },
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    color: Colors.amber,
                    child: const Center(
                      child: Text(
                        'IOS Button',
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Text(
              "Platform Indicator",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlatformIndicator(PlatformTarget.android).build(),
              const SizedBox(width: 40),
              PlatformIndicator(PlatformTarget.ios).build(),
            ],
          ),
          const SizedBox(height: 60),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Text(
              "Platform Switch",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlatformSwitch(PlatformTarget.android).build((value) {
                setState(() {
                  isAndroid = value;
                });
              }, isAndroid),
              const SizedBox(width: 40),
              PlatformSwitch(PlatformTarget.ios).build((value) {
                setState(() {
                  isIOS = value;
                });
              }, isIOS),
            ],
          ),
        ],
      ),
    );
  }
}

class AndroidSwitch implements PlatformSwitch {
  @override
  Widget build(Function(bool) onChanged, bool isToggle) {
    return Switch(
      value: isToggle,
      onChanged: onChanged,
      activeColor: Colors.cyan,
    );
  }
}

class IOSSwitch implements PlatformSwitch {
  @override
  Widget build(Function(bool) onChanged, bool isToggle) {
    return CupertinoSwitch(value: isToggle, onChanged: onChanged);
  }
}

abstract class PlatformSwitch {
  Widget build(Function(bool) onChanged, bool isToggle);

  factory PlatformSwitch(PlatformTarget target) {
    switch (target) {
      case PlatformTarget.android:
        return AndroidSwitch();
      case PlatformTarget.ios:
        return IOSSwitch();
      default:
        return AndroidSwitch();
    }
  }
}

class IOSIndicator implements PlatformIndicator {
  @override
  Widget build() {
    return const CupertinoActivityIndicator(
      color: Colors.green,
    );
  }
}

class AndroidIndicator implements PlatformIndicator {
  @override
  Widget build() {
    return const CircularProgressIndicator(
      color: Colors.green,
    );
  }
}

abstract class PlatformIndicator {
  Widget build();

  factory PlatformIndicator(PlatformTarget target) {
    switch (target) {
      case PlatformTarget.android:
        return AndroidIndicator();
      case PlatformTarget.ios:
        return IOSIndicator();
      default:
        return AndroidIndicator();
    }
  }
}

enum PlatformTarget {
  android,
  ios;
}

class AndroidButton implements PlatformButton {
  @override
  Widget build(VoidCallback onPressed, Widget child) {
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}

class IOSButton implements PlatformButton {
  @override
  Widget build(VoidCallback onPressed, Widget child) {
    return CupertinoButton(child: child, onPressed: onPressed);
  }
}

abstract class PlatformButton {
  Widget build(VoidCallback onPressed, Widget child);

  factory PlatformButton(PlatformTarget target) {
    switch (target) {
      case PlatformTarget.android:
        return AndroidButton();
      case PlatformTarget.ios:
        return IOSButton();
      default:
        return AndroidButton();
    }
  }
}
