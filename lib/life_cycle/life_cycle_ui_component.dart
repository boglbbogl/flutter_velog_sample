import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ListView lifeCycleUIListView({
  required List<String> data,
  required BuildContext context,
}) {
  return ListView(
    children: [
      const SizedBox(height: 12),
      ...data.map(
        (e) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    e.split("/")[0],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: e.split("/")[0] == "Inactive"
                          ? Colors.amber
                          : e.split("/")[0] == "Stop"
                              ? Colors.amber.shade200
                              : e.split("/")[0] == "Detached"
                                  ? Colors.deepOrange
                                  : e.split("/")[0] == "Restart"
                                      ? Colors.blue.shade200
                                      : e.split("/")[0] == "Resumed"
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
  );
}

FloatingActionButton lifeCycleUIFab(Future<void> Function() onTap) {
  return FloatingActionButton(
    elevation: 0,
    focusColor: Colors.black,
    backgroundColor: Colors.black,
    onPressed: () {
      HapticFeedback.mediumImpact();
      onTap();
    },
    child: const Icon(
      Icons.delete_forever_rounded,
    ),
  );
}
