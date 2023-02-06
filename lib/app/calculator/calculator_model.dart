class CalculatorModel {
  final String? symbol;
  final int? number;
  const CalculatorModel({
    this.symbol,
    this.number,
  });

  static List<CalculatorModel> model = [
    const CalculatorModel(number: 7),
    const CalculatorModel(number: 8),
    const CalculatorModel(number: 9),
    const CalculatorModel(symbol: "/"),
    const CalculatorModel(number: 4),
    const CalculatorModel(number: 5),
    const CalculatorModel(number: 6),
    const CalculatorModel(symbol: "*"),
    const CalculatorModel(number: 1),
    const CalculatorModel(number: 2),
    const CalculatorModel(number: 3),
    const CalculatorModel(symbol: "-"),
    const CalculatorModel(symbol: "AC"),
    const CalculatorModel(number: 0),
    const CalculatorModel(symbol: "+"),
  ];
}
