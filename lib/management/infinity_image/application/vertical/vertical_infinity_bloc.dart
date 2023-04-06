import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/vertical/vertical_infinity_event.dart';
import 'package:flutter_velog_sample/management/infinity_image/application/vertical/vertical_infinity_state.dart';
import 'package:flutter_velog_sample/management/infinity_image/model/infinity_image_model.dart';
import 'package:flutter_velog_sample/management/infinity_image/model/vertical_image_type.dart';
import 'package:flutter_velog_sample/management/infinity_image/repository/infinity_image_repository.dart';

class VerticalInfinityBloc
    extends Bloc<VerticalInfinityEvent, VerticalInfinityState> {
  final InfinityImageRepository _repository = InfinityImageRepository.instance;
  VerticalInfinityBloc() : super(const VerticalInfinityState()) {
    on<VerticalInitImagesEvent>(_initImages);
    on<VerticalMoreImageEvent>(_moerImages);
  }

  Future<void> _initImages(
      VerticalInfinityEvent event, Emitter<VerticalInfinityState> emit) async {
    List<InfinityImageModel>? _images =
        await _repository.fetchVerticalImages(pageNo: state.pageNo);
    if (_images != null) {
      emit(state.copyWith(
        images: _images,
        type: VerticalImageType.loaded,
        pageNo: state.pageNo + 1,
      ));
    } else {
      emit(state.copyWith(message: "Error"));
    }
  }

  Future<void> _moerImages(
      VerticalMoreImageEvent event, Emitter<VerticalInfinityState> emit) async {
    if (event.notification.metrics.maxScrollExtent * 0.9 <
            event.notification.metrics.pixels &&
        state.type != VerticalImageType.more) {
      emit(state.copyWith(type: VerticalImageType.more));
      List<InfinityImageModel>? _images =
          await _repository.fetchVerticalImages(pageNo: state.pageNo);
      if (_images != null) {
        emit(state.copyWith(
            images: [...state.images!, ..._images], pageNo: state.pageNo + 1));
        await Future.delayed(const Duration(seconds: 1)).whenComplete(
            () => emit(state.copyWith(type: VerticalImageType.loaded)));
      } else {
        emit(state.copyWith(message: "Error"));
      }
    }
  }
}
