class CalanderModel {
  final int year;
  final int month;
  final List<int> days;
  const CalanderModel({
    required this.year,
    required this.month,
    required this.days,
  });

  CalanderModel copyWith({
    final int? year,
    final int? month,
    final List<int>? days,
  }) {
    return CalanderModel(
      year: year ?? this.year,
      month: month ?? this.month,
      days: days ?? this.days,
    );
  }

  factory CalanderModel.empty() =>
      const CalanderModel(year: 0, month: 0, days: []);
}
