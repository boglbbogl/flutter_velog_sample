class SingletonExampleModel {
  static final SingletonExampleModel instance =
      SingletonExampleModel._internal();
  factory SingletonExampleModel() => instance;
  SingletonExampleModel._internal();

  String title = "Singleton";
  int count = 0;
}

class GeneralExampleModel {
  String title = "General";
  int count = 0;
}
