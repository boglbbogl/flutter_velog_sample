import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/horizontal/horizontal_infinity_event.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/horizontal/horizontal_infinity_state.dart';
import 'package:flutter_velog_sample/management/infinity_image/model/infinity_image_model.dart';
import 'package:flutter_velog_sample/management/infinity_image/repository/infinity_image_repository.dart';

class HorizontalInfinityBloc
    extends Bloc<HorizontalInfinityEvent, HorizontalInfinityState> {
  final InfinityImageRepository _repository = InfinityImageRepository.instance;

  HorizontalInfinityBloc() : super(const HorizontalInitState()) {
    on<HorizontalInitImagesEvent>(_initEvent);
    on<HorizontalMoreImageEvent>(_moreEvent);
  }

  Future<void> _initEvent(HorizontalInitImagesEvent event,
      Emitter<HorizontalInfinityState> emit) async {
    await Future.delayed(const Duration(seconds: 1), () async {
      emit(HorizontalDownLoadedState(isError: state.isError));
      List<InfinityImageModel>? _images =
          await _repository.fetchHorizotalImages(pageNo: state.pageNo);
      if (_images != null) {
        emit(HorizontalLoadedState(images: _images, pageNo: state.pageNo + 1));
      } else {
        emit(const HorizontalErrorState(isError: true, images: []));
      }
    });
  }

  Future<void> _moreEvent(HorizontalMoreImageEvent event,
      Emitter<HorizontalInfinityState> emit) async {
    if (state is HorizontalLoadedState) {
      List<InfinityImageModel>? _images =
          await _repository.fetchHorizotalImages(pageNo: state.pageNo);
      if (_images != null) {
        emit(HorizontalLoadedState(images: [...state.images!, ..._images]));
      } else {
        emit(const HorizontalErrorState(isError: true, images: []));
      }
    }
  }
}
