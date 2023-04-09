import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/management/bloc_listener/bloc/text_listener_bloc.dart';
import 'package:flutter_velog_sample/management/bloc_listener/bloc/text_listener_event.dart';
import 'package:flutter_velog_sample/management/bloc_listener/bloc/text_listener_state.dart';

class BlocListenerScreen extends StatelessWidget {
  const BlocListenerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TextListenerBloc>(
      create: (_) => TextListenerBloc(),
      child: BlocBuilder<TextListenerBloc, TextListenerState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: "BLoC Listener"),
            body: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      context
                          .read<TextListenerBloc>()
                          .add(TextAddListenerEvent("123213"));
                    },
                    child: Text("data")),
              ],
            ),
          );
        },
      ),
    );
  }
}
