import 'package:flutter/material.dart';

Stack countScreenPublicUI({
  required BuildContext context,
  required int count,
  required int selectCount,
  required Function() onIncrement,
  required Function() onDecrement,
  required Function() onReset,
  required Function(int) onCount,
}) {
  return Stack(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "$count",
                  style: const TextStyle(
                      fontSize: 60, fontWeight: FontWeight.bold),
                ),
              )),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onIncrement,
                child: const Icon(
                  Icons.add_circle_outline,
                  size: 40,
                ),
              ),
              const SizedBox(width: 24),
              GestureDetector(
                onTap: onDecrement,
                child: const Icon(
                  Icons.remove_circle_outline,
                  size: 40,
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: onReset,
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: 48,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(71, 71, 71, 1),
                  borderRadius: BorderRadius.circular(12)),
              child: const Center(
                child: Text(
                  'Reset',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
      Positioned(
        top: 20,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                countAppSelectedCountBox(
                    onTap: onCount, selectNumber: selectCount, number: 1),
                countAppSelectedCountBox(
                    onTap: onCount, selectNumber: selectCount, number: 10),
                countAppSelectedCountBox(
                    onTap: onCount, selectNumber: selectCount, number: 20),
                countAppSelectedCountBox(
                    onTap: onCount, selectNumber: selectCount, number: 50),
                countAppSelectedCountBox(
                    onTap: onCount, selectNumber: selectCount, number: 100),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

GestureDetector countAppSelectedCountBox({
  required Function(int) onTap,
  required int number,
  required int selectNumber,
}) {
  return GestureDetector(
    onTap: () => onTap(number),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            color: selectNumber == number
                ? const Color.fromRGBO(91, 91, 91, 1)
                : const Color.fromRGBO(61, 61, 61, 1),
            borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: Text(
          '$number',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectNumber == number
                  ? Colors.white
                  : const Color.fromRGBO(155, 155, 155, 1)),
        )),
      ),
    ),
  );
}
