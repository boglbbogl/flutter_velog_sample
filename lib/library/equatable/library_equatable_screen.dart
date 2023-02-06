import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class LibraryEquatableScreen extends StatelessWidget {
  const LibraryEquatableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Car _car1 = Car("G80", "Sedan", 6000);
    Car _car2 = Car("G80", "Sedan", 8000);
    return Scaffold(
      appBar: appBar(title: "Equatable Library"),
      body: Column(
        children: [
          GestureDetector(
              onTap: () {
                print(_car1.title == _car2.title);
                print(_car1.type == _car2.type);
                print(_car1.price == _car2.price);
                print(_car1 == _car2);
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.amber,
              )),
        ],
      ),
    );
  }
}

class Car extends Object {
  final String title;
  final String type;
  final int price;
  const Car(this.title, this.type, this.price);

  @override
  bool operator ==(Object other) {
    return other is Car && title == other.title;
  }

  @override
  int get hashCode {
    return title.hashCode;
  }
}
