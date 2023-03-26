enum StopwatchState {
  run,
  stop,
  reset,
}

class AppStopwatchModel {
  final String hour;
  final String minute;
  final String seconds;
  final String millseconds;
  const AppStopwatchModel({
    required this.hour,
    required this.minute,
    required this.seconds,
    required this.millseconds,
  });

  factory AppStopwatchModel.empty() => const AppStopwatchModel(
      hour: "00", minute: "00", seconds: "00", millseconds: "00");
}
