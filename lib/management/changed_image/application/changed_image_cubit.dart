import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/management/changed_image/application/changed_image_state.dart';
import 'package:flutter_velog_sample/management/changed_image/repository/changed_image_repository.dart';

class ChangedImageCubit extends Cubit<ChangedImageState> {
  ChangedImageCubit() : super(ImageInitState());

  final ChangedImageRepository _repository = ChangedImageRepository.instance;

  Future<void> getImage() async {
    emit(ImageLoadingState(pageNo: state.pageNo));
    String? _url = await _repository.fetchImage(pageNo: state.pageNo);
    if (_url != null) {
      emit(ImageLoadedState(imageUrl: _url, pageNo: state.pageNo + 1));
    } else {
      emit(const ImageErrorState("Error"));
    }
  }
}
