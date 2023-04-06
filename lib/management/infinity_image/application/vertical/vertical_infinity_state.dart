import 'package:equatable/equatable.dart';
import 'package:flutter_velog_sample/management/infinity_image/model/infinity_image_model.dart';
import 'package:flutter_velog_sample/management/infinity_image/model/vertical_image_type.dart';

class VerticalInfinityState extends Equatable {
  final List<InfinityImageModel>? images;
  final VerticalImageType type;
  final String? message;
  final int pageNo;

  const VerticalInfinityState({
    this.images,
    this.type = VerticalImageType.loading,
    this.message,
    this.pageNo = 1,
  });

  VerticalInfinityState copyWith({
    final List<InfinityImageModel>? images,
    final VerticalImageType? type,
    final String? message,
    final int? pageNo,
  }) {
    return VerticalInfinityState(
      images: images ?? this.images,
      type: type ?? this.type,
      message: message,
      pageNo: pageNo ?? this.pageNo,
    );
  }

  @override
  List<Object?> get props => [images, type, message, pageNo];
}
