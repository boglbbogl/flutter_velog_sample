import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_size.dart';
import 'package:flutter_velog_sample/main_provider.dart';
import 'package:provider/provider.dart';

void mainLifeCycleCheckView({
  required BuildContext context,
}) {
  showModalBottomSheet(
      context: context,
      builder: (context) => Container(
          width: size.width,
          height: size.height * 0.8,
          color: const Color.fromRGBO(71, 71, 71, 1),
          child: Stack(
            children: [
              ListView(
                children: [
                  const SizedBox(height: 12),
                  ...context.watch<MainProvider>().lifeCycle.map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                    e.split("/")[0],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: e.split("/")[0] == "inactive"
                                          ? Colors.amber
                                          : e.split("/")[0] == "detached"
                                              ? Colors.deepOrange
                                              : e.split("/")[0] == "paused"
                                                  ? Colors.blue
                                                  : Colors.green,
                                    ),
                                  )),
                              const SizedBox(width: 12),
                              Text(
                                e.split("/")[1],
                                style: const TextStyle(
                                  color: Color.fromRGBO(195, 195, 195, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                ],
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () => context.read<MainProvider>().resetLocalStorage(),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromRGBO(115, 115, 115, 1),
                    ),
                    child: const Icon(Icons.delete_outlined),
                  ),
                ),
              ),
            ],
          )),
      isScrollControlled: true);
}
