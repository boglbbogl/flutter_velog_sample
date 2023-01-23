import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_sample_data.freezed.dart';
part 'freezed_sample_data.g.dart';

@freezed
class FreezedSampleData with _$FreezedSampleData {
  const factory FreezedSampleData({
    required String name,
    required int age,
    required String address,
    required int sex,
    required bool isMarried,
  }) = _FreezedSampleData;
  const FreezedSampleData._();
  factory FreezedSampleData.fromJson(Map<String, dynamic> json) =>
      _$FreezedSampleDataFromJson(json);

  factory FreezedSampleData.empty() => const FreezedSampleData(
        name: "홍 길동",
        age: 0,
        address: "",
        sex: 0,
        isMarried: false,
      );
}
