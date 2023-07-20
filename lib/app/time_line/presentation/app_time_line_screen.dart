import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/time_line/application/time_line_bloc.dart';
import 'package:flutter_velog_sample/app/time_line/application/time_line_state.dart';
import 'package:flutter_velog_sample/app/time_line/presentation/create_time_line_screen.dart';
import 'package:flutter_velog_sample/app/time_line/presentation/time_line_date_to_string.dart';

class AppTimeLineScreen extends StatelessWidget {
  const AppTimeLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimeLineBloc>(
      create: (_) => TimeLineBloc(),
      child: BlocBuilder<TimeLineBloc, TimeLineState>(
        builder: (context, state) {
          if (state is TimeLineLoadingState) {
            return Container(
              color: const Color.fromRGBO(71, 71, 71, 1),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              ),
            );
          }
          return Scaffold(
            appBar: appBar(title: "Time Line"),
            floatingActionButton: FloatingActionButton(
              child: const Icon(
                Icons.add,
                color: Color.fromRGBO(195, 195, 195, 1),
              ),
              backgroundColor: const Color.fromRGBO(81, 81, 81, 1),
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const CreateTimeLineScreen()));
              },
            ),
            body: ListView.builder(
                itemCount: state.timeLines.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 40,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 25, right: 10),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Text(timeLineTimeToString(TimeOfDay(
                              hour: state.timeLines[index].time.toDate().hour,
                              minute: state.timeLines[index].time
                                  .toDate()
                                  .minute))),
                        ),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromRGBO(95, 95, 95, 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                                child: Text(
                              state.timeLines[index].type,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(215, 215, 215, 1)),
                            )),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          state.timeLines[index].content,
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
