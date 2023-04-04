import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:flutter_velog_sample/management/cubit/management_cubit.dart';
import 'package:flutter_velog_sample/management/cubit/management_state.dart';

class ManagementCubitScreen extends StatelessWidget {
  const ManagementCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    logger.e("123213123123123");
    return BlocProvider<ManagementCubit>(
      lazy: false,
      create: (context) => ManagementCubit(),
      child: const _ManagementCubitScreen(),
    );
  }
}

class _ManagementCubitScreen extends StatelessWidget {
  const _ManagementCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    logger.e("kljdaf;kljdfjsdklfa");

    return Scaffold(
      appBar: appBar(title: "Cubit"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                context.read<ManagementCubit>().increment();
              },
              child: Text(
                context.watch<ManagementCubit>().state.count.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 100,
                    color: Colors.deepOrange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
