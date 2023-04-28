import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/address/depth/application/address_depth_bloc.dart';
import 'package:flutter_velog_sample/app/address/depth/application/address_depth_event.dart';
import 'package:flutter_velog_sample/app/address/depth/application/address_depth_state.dart';
import 'package:flutter_velog_sample/app/address/model/depth/address_depth_server_model.dart';

class AddressDepthScreen extends StatelessWidget {
  const AddressDepthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQueryData.fromWindow(window).size.width;
    return BlocProvider<AddressDepthBloc>(
      create: (_) => AddressDepthBloc(),
      child: BlocConsumer<AddressDepthBloc, AddressDepthState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AddressDepthInitState) {
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: _width,
                  height: 60,
                  color: Colors.red,
                  child: Row(
                    children: [
                      Text(state.address!.major.address.length.toString()),
                      Text(state.address!.middle.address.length.toString()),
                      Text(state.address!.minor.address.length.toString()),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      if (state is! AddressDepthMinorState) ...[
                        _listView(
                            width: state is AddressDepthMajorState
                                ? _width
                                : _width - 200,
                            color: const Color.fromRGBO(61, 61, 61, 1),
                            onTap: (i) => context.read<AddressDepthBloc>().add(
                                AddressDepthMiddleEvent(
                                    code:
                                        state.address!.major.address[i].code)),
                            address: state.address!.major.address)
                      ],
                      if (state is AddressDepthMiddleState ||
                          state is AddressDepthMinorState) ...[
                        _listView(
                            width: state is AddressDepthMiddleState
                                ? _width - (_width - 200)
                                : _width - 200,
                            color: const Color.fromRGBO(71, 71, 71, 1),
                            onTap: (i) => context.read<AddressDepthBloc>().add(
                                AddressDepthMinorEvent(
                                    code:
                                        state.address!.middle.address[i].code)),
                            address: state.address!.middle.address)
                      ],
                      if (state is AddressDepthMinorState) ...[
                        _listView(
                            width: _width - (_width - 200),
                            color: const Color.fromRGBO(81, 81, 81, 1),
                            onTap: (i) {},
                            address: state.address!.minor.address)
                      ],
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _listView({
    required double width,
    required Function(int) onTap,
    required List<AddressDepthServerModel> address,
    required Color color,
  }) {
    return Container(
      color: color,
      width: width,
      child: ListView.builder(
        itemCount: address.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 50,
                child: Text(
                  address[index].name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(215, 215, 215, 1),
                      fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
