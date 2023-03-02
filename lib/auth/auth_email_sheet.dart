import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_size.dart';
import 'package:flutter_velog_sample/main_provider.dart';
import 'package:provider/provider.dart';

void authEmailSheet(
  BuildContext context, {
  bool isSignUp = false,
}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            color: const Color.fromRGBO(71, 71, 71, 1),
            child: SafeArea(
                child: GestureDetector(
              onTap: () {
                if (isSignUp) {
                  context.read<MainProvider>().createEmailAndPassword(
                        context,
                        email: "tygervelog@test.com",
                        password: "123123123",
                      );
                } else {
                  context.read<MainProvider>().signInWithEMail(
                        context,
                        email: "tygervelog@test.com",
                        password: "123123123",
                      );
                }
              },
              child: Container(
                color: const Color.fromRGBO(71, 71, 71, 1),
                width: size.width,
                height: size.height * 0.25,
                child: DefaultTextStyle(
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("tygervelog@test.com"),
                      SizedBox(height: 8),
                      Text("123123123"),
                    ],
                  ),
                ),
              ),
            )));
      },
      isScrollControlled: true);
}
