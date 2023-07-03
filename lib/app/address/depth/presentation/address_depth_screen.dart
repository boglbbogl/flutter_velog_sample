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
    double _width = MediaQuery.of(context).size.width;
    return BlocProvider<AddressDepthBloc>(
      create: (_) => AddressDepthBloc(),
      child: BlocConsumer<AddressDepthBloc, AddressDepthState>(
        listener: (context, state) {
          if (state is AddressDepthErrorState) {
            Navigator.of(context).pop();
          }
        },
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
                SizedBox(
                  width: _width,
                  height: 60,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.amber),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          if (state is AddressDepthMajorState) ...[
                            const Text("주소를 선택해주세요")
                          ],
                          if (state.address!.major.current != null) ...[
                            GestureDetector(
                                onTap: () => context
                                    .read<AddressDepthBloc>()
                                    .add(AddressDepthResetEvent(type: 0)),
                                child:
                                    Text(state.address!.major.current!.name)),
                          ],
                          if (state.address!.middle.current != null) ...[
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 4, right: 4, bottom: 2),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: Colors.amber,
                              ),
                            ),
                            GestureDetector(
                                onTap: () => context
                                    .read<AddressDepthBloc>()
                                    .add(AddressDepthResetEvent(type: 1)),
                                child:
                                    Text(state.address!.middle.current!.name)),
                          ],
                          if (state.address!.minor.current != null) ...[
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 4, right: 4, bottom: 2),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: Colors.amber,
                              ),
                            ),
                            Text(state.address!.minor.current!.name),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      if (state is! AddressDepthMinorState) ...[
                        _listView(
                          width: state is AddressDepthMajorState ? _width : 130,
                          color: const Color.fromRGBO(61, 61, 61, 1),
                          selecteColor: const Color.fromRGBO(71, 71, 71, 1),
                          onTap: (i) => context.read<AddressDepthBloc>().add(
                              AddressDepthMiddleEvent(
                                  selected: state.address!.major.address[i])),
                          address: state.address!.major.address,
                          selected: state.address!.major.current,
                        )
                      ],
                      if (state is AddressDepthMiddleState ||
                          state is AddressDepthMinorState) ...[
                        _listView(
                          width: state is AddressDepthMiddleState
                              ? _width - 130
                              : 130,
                          color: const Color.fromRGBO(71, 71, 71, 1),
                          selecteColor: const Color.fromRGBO(81, 81, 81, 1),
                          onTap: (i) => context.read<AddressDepthBloc>().add(
                              AddressDepthMinorEvent(
                                  selected: state.address!.middle.address[i])),
                          address: state.address!.middle.address,
                          selected: state.address!.middle.current,
                        )
                      ],
                      if (state is AddressDepthMinorState) ...[
                        _listView(
                          width: _width - 130,
                          color: const Color.fromRGBO(81, 81, 81, 1),
                          selecteColor: Colors.green,
                          onTap: (i) => context.read<AddressDepthBloc>().add(
                              AddressDepthFinishEvent(
                                  selected: state.address!.minor.address[i])),
                          address: state.address!.minor.address,
                          selected: state.address!.minor.current,
                        )
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
    required Color selecteColor,
    required AddressDepthServerModel? selected,
  }) {
    return Container(
      color: color,
      width: width,
      child: ListView.builder(
        itemCount: address.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              color: selected == null
                  ? Colors.transparent
                  : selected == address[index]
                      ? selecteColor
                      : color,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      address[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(215, 215, 215, 1),
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
