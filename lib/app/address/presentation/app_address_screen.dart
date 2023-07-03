import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/address/depth/presentation/address_depth_screen.dart';
import 'package:flutter_velog_sample/app/address/step/presentation/address_step_screen.dart';

class AppAddressScreen extends StatelessWidget {
  const AppAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Address"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buttonForm(
              context: context, title: "STEP", widget: AddressStepScreen()),
          _buttonForm(
              context: context,
              title: "DEPTH",
              widget: const AddressDepthScreen()),
        ],
      ),
    );
  }

  GestureDetector _buttonForm({
    required BuildContext context,
    required String title,
    required Widget widget,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.green),
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.amber),
            ),
          ),
        ),
      ),
    );
  }
}
