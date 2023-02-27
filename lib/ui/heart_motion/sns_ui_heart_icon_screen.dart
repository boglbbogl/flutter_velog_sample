import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/ui/heart_motion/sns_ui_heart_component.dart';
import 'package:flutter_velog_sample/ui/heart_motion/sns_ui_heart_provider.dart';
import 'package:provider/provider.dart';

class SnsUIHeartIconScreen extends StatelessWidget {
  const SnsUIHeartIconScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SnsUIHeartProvider>(
      create: (_) => SnsUIHeartProvider(),
      child: Consumer<SnsUIHeartProvider>(builder: (context, state, child) {
        return Scaffold(
            appBar: appBar(title: 'SNS Heart Icon'),
            body: snsUIHeartComponent(
                context: context,
                isHeart: state.isHeart,
                imageIndex: 204,
                onHeartTap: () => state.onHeartTap()));
      }),
    );
  }
}
