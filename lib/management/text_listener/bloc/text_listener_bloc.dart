import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/management/text_listener/bloc/text_listener_event.dart';
import 'package:flutter_velog_sample/management/text_listener/bloc/text_listener_state.dart';

class TextListenerBloc extends Bloc<TextListenerEvent, TextListenerState> {
  TextListenerBloc() : super(TextListenerInitState()) {
    on<TextAddListenerEvent>(_textAddListener);
  }

  void _textAddListener(
      TextAddListenerEvent event, Emitter<TextListenerState> emit) {
    emit(TextListenerInputState());
    String _text = event.controller.text.isNotEmpty
        ? event.controller.text.substring(event.controller.text.length - 1)
        : "";
    bool _equal = RegExp(r'''[a-zㄱ-ㅎ가-힣ㅏ-ㅣ]''').hasMatch(_text);
    if (!_equal && _text.isNotEmpty) {
      if (RegExp(r'''[A-Z]''').hasMatch(_text)) {
        emit(TextListenerUpperErrorState(message: "대문자 '$_text' 는 입력할 수 없습니다"));
      } else if (RegExp(r'''[0-9]''').hasMatch(_text)) {
        emit(TextListenerNumberErrorState(message: "숫자 '$_text' 는 입력할 수 없습니다"));
      } else {
        emit(TextListenerSpecialErrorState(
            message: "특수문자 '$_text' 는 입력할 수 없습니다"));
      }
      event.controller.text =
          event.controller.text.substring(0, event.controller.text.length - 1);
    }
  }
}
