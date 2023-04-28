import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/address/depth/application/address_depth_bloc.dart';
import 'package:flutter_velog_sample/app/address/depth/application/address_depth_state.dart';

class AddressDepthScreen extends StatelessWidget {
  const AddressDepthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double _height = MediaQueryData.fromWindow(window).size.height;
    return BlocProvider<AddressDepthBloc>(
      create: (_) => AddressDepthBloc(),
      child: BlocConsumer<AddressDepthBloc, AddressDepthState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.address == null) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            );
          }
          return Scaffold(
            appBar: appBar(title: "Depth Address"),
            body: SizedBox(
              height: _height,
              width: MediaQueryData.fromWindow(window).size.width,
              child: Stack(
                children: [
                  Container(
                    width: MediaQueryData.fromWindow(window).size.width,
                    height: 60,
                    color: Colors.red,
                  ),
                  AnimatedPositioned(
                    top: 60,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: MediaQueryData.fromWindow(window).size.width,
                      height: _height,
                      color: Colors.amber,
                      child: ListView.builder(
                          itemCount: state.address!.major.address.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Text(state.address!.major.address[index].name),
                                Icon(Icons.arrow_forward_ios_outlined),
                              ],
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
