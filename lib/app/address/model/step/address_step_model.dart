class AddressStepModel {
  final String name;
  final List<AddressStepMinor> names;

  const AddressStepModel({required this.name, required this.names});
}

class AddressStepMinor {
  final String name;

  AddressStepMinor({required this.name});

  factory AddressStepMinor.fromJson(Map<String, dynamic> json) {
    return AddressStepMinor(name: json["addr_name"]);
  }
}
