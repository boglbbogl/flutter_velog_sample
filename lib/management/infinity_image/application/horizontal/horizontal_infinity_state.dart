import 'package:equatable/equatable.dart';
import 'package:flutter_velog_sample/management/infinity_image/model/infinity_image_model.dart';

abstract class HorizontalInfinityState extends Equatable {
  final int pageNo;
  final List<InfinityImageModel>? images;
  final bool isError;
  const HorizontalInfinityState({
    this.pageNo = 30,
    this.images,
    this.isError = false,
  });
}

class HorizontalInitState extends HorizontalInfinityState {
  const HorizontalInitState();
  @override
  List<Object?> get props => [];
}

class HorizontalDownLoadedState extends HorizontalInfinityState {
  const HorizontalDownLoadedState({super.isError});
  @override
  List<Object?> get props => [isError];
}

class HorizontalLoadedState extends HorizontalInfinityState {
  const HorizontalLoadedState({super.images, super.pageNo});
  @override
  List<Object?> get props => [images, pageNo];
}

class HorizontalMoreState extends HorizontalInfinityState {
  @override
  List<Object?> get props => [];
}

class HorizontalErrorState extends HorizontalInfinityState {
  const HorizontalErrorState({super.isError, super.images});
  @override
  List<Object?> get props => [isError, images];
}
