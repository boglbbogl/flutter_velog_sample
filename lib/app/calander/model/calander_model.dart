class CalanderModel {
  final List<TestModel> testModel;

  const CalanderModel({
    required this.testModel,
  });

  CalanderModel copyWith({
    final List<TestModel>? testModel,
  }) {
    return CalanderModel(
      testModel: testModel ?? this.testModel,
    );
  }

  factory CalanderModel.empty() => const CalanderModel(testModel: []);
}

class TestModel {
  final int number;
  final String name;

  const TestModel({
    required this.number,
    required this.name,
  });
}
