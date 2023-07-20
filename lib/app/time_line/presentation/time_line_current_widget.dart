import 'package:flutter/material.dart';

class TimeLineCurrentWidget extends StatelessWidget {
  final DateTime date;
  final double standardIndex;
  final Function(bool) onChanged;
  final Function(bool) onTap;
  const TimeLineCurrentWidget({
    super.key,
    required this.date,
    required this.onChanged,
    required this.standardIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 12),
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              date.toString().substring(0, 7).replaceAll("-", ", "),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => onChanged(false),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 20,
                        color: Colors.amber.withOpacity(0.8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      date.toString().substring(8, 10),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.amber),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onChanged(true),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Colors.amber.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => onTap(false),
                    child: const Icon(
                      Icons.remove_circle_outline_rounded,
                      size: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      standardIndex.toString().substring(0, 3),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onTap(true),
                    child: const Icon(
                      Icons.add_circle_outline_rounded,
                      size: 18,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
