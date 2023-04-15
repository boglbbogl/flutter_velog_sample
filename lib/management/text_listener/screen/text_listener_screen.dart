import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/management/text_listener/bloc/text_listener_bloc.dart';
import 'package:flutter_velog_sample/management/text_listener/bloc/text_listener_event.dart';

import 'package:flutter_velog_sample/management/text_listener/bloc/text_listener_state.dart';

class TextListenerScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  TextListenerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TextListenerBloc>(
      create: (context) => TextListenerBloc(),
      child: BlocListener<TextListenerBloc, TextListenerState>(
        listener: (context, state) {
          if (state is TextListenerUpperErrorState ||
              state is TextListenerNumberErrorState ||
              state is TextListenerSpecialErrorState) {
            FocusScope.of(context).unfocus();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.amber,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 24),
                      child: Text(
                        state.message,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 24),
                      ),
                    ))));
          }
        },
        child: _TextListenerScreen(controller: controller),
      ),
    );
  }
}

class _TextListenerScreen extends StatelessWidget {
  final TextEditingController controller;
  const _TextListenerScreen({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: appBar(title: "Text Listener"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                "BLoC Listener",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: Colors.amber),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    onChanged: (String value) => context
                        .read<TextListenerBloc>()
                        .add(TextAddListenerEvent(controller)),
                    controller: controller,
                    cursorColor: Colors.deepOrange,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                        fontSize: 16),
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
