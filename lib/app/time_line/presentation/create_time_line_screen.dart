import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/time_line/application/create/create_time_line_cubit.dart';
import 'package:flutter_velog_sample/app/time_line/application/create/create_time_line_state.dart';
import 'package:flutter_velog_sample/app/time_line/presentation/time_line_date_to_string.dart';

class CreateTimeLineScreen extends StatelessWidget {
  const CreateTimeLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTimeLineCubit>(
      create: (_) => CreateTimeLineCubit()..init(),
      child: BlocConsumer<CreateTimeLineCubit, CreateTimeLineState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.of(context).pop(state.time);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: appBar(title: "Create Time Line"),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 24),
                      DefaultTextStyle(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  HapticFeedback.mediumImpact();
                                  DateTime? date = await showDatePicker(
                                    context: context,
                                    currentDate: state.time,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  context
                                      .read<CreateTimeLineCubit>()
                                      .changedDateTime(date, null);
                                },
                                child: Text(timeLineDateToString(state.time))),
                            const SizedBox(width: 24),
                            GestureDetector(
                                onTap: () async {
                                  HapticFeedback.mediumImpact();
                                  TimeOfDay? time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: state.time.hour,
                                        minute: state.time.minute),
                                  );
                                  context
                                      .read<CreateTimeLineCubit>()
                                      .changedDateTime(null, time);
                                },
                                child: Text(timeLineTimeToString(TimeOfDay(
                                    hour: state.time.hour,
                                    minute: state.time.minute))))
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                          height: 55,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                ...state.typeList.map((e) => GestureDetector(
                                      onTap: () {
                                        HapticFeedback.mediumImpact();
                                        context
                                            .read<CreateTimeLineCubit>()
                                            .selectType(e);
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: state.type != null &&
                                                    state.type == e
                                                ? const Color.fromRGBO(
                                                    91, 91, 91, 1)
                                                : const Color.fromRGBO(
                                                    125, 125, 125, 1),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 12),
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          child: Text(
                                            e,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: state.type != null &&
                                                      state.type == e
                                                  ? Colors.amber
                                                  : const Color.fromRGBO(
                                                      195, 195, 195, 1),
                                            ),
                                          )),
                                    ))
                              ],
                            ),
                          )),
                      const SizedBox(height: 24),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromRGBO(125, 125, 125, 1),
                        ),
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          maxLines: 10,
                          onChanged: (String value) => context
                              .read<CreateTimeLineCubit>()
                              .inputContent(value),
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          context.read<CreateTimeLineCubit>().submitted();
                        },
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: state.isSubmitted
                                  ? Colors.amber
                                  : const Color.fromRGBO(125, 125, 125, 1),
                            ),
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Center(
                              child: Text(
                                "SAVE",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: state.isSubmitted
                                        ? const Color.fromRGBO(71, 71, 71, 1)
                                        : const Color.fromRGBO(
                                            195, 195, 195, 1),
                                    fontSize: 18),
                              ),
                            )),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 12),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
