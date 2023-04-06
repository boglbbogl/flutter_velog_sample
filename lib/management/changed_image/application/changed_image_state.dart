import 'package:equatable/equatable.dart';

abstract class ChangedImageState extends Equatable {
  final String? imageUrl;
  final int pageNo;
  const ChangedImageState({this.imageUrl, this.pageNo = 1});
}

class ImageInitState extends ChangedImageState {
  @override
  List<Object?> get props => [];
}

class ImageLoadingState extends ChangedImageState {
  const ImageLoadingState({super.pageNo});
  @override
  List<Object?> get props => [pageNo];
}

class ImageLoadedState extends ChangedImageState {
  const ImageLoadedState({super.imageUrl, super.pageNo});
  @override
  List<Object?> get props => [imageUrl, pageNo];
}

class ImageErrorState extends ChangedImageState {
  final String errorMessage;
  const ImageErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
