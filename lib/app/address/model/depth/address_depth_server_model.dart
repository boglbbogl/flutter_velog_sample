class AddressDepthServerModel {
  final String code;
  final String name;

  AddressDepthServerModel({
    required this.code,
    required this.name,
  });

  factory AddressDepthServerModel.fromJson(Map<String, dynamic> json) {
    return AddressDepthServerModel(
      code: json["cd"],
      name: json["addr_name"],
    );
  }
}
