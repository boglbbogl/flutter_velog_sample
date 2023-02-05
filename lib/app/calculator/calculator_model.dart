class CalculatorModel {
  final String? symbol;
  final int? number;
  const CalculatorModel(
    this.symbol,
    this.number,
  );

  static List<CalculatorModel> model = [
    const CalculatorModel(null, 7),
    const CalculatorModel(null, 8),
    const CalculatorModel(null, 9),
    const CalculatorModel("/", null),
    const CalculatorModel(null, 4),
    const CalculatorModel(null, 5),
    const CalculatorModel(null, 6),
    const CalculatorModel("*", null),
    const CalculatorModel(null, 1),
    const CalculatorModel(null, 2),
    const CalculatorModel(null, 3),
    const CalculatorModel("-", null),
    const CalculatorModel("AC", null),
    const CalculatorModel(null, 0),
    const CalculatorModel("+", null),
  ];
}
