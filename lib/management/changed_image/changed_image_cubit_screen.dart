import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/management/changed_image/changed_image_repository.dart';

class ChangedImageCubitScreen extends StatelessWidget {
  const ChangedImageCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Cubit Changed Image"),
      body: Center(
          child: GestureDetector(
              onTap: () {
                ChangedImageRepository.instance.fetchImage();
              },
              child: Text("dsflds"))),
    );
  }
}
