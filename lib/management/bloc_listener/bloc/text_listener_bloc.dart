import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:flutter_velog_sample/management/bloc_listener/bloc/text_listener_event.dart';
import 'package:flutter_velog_sample/management/bloc_listener/bloc/text_listener_state.dart';

class TextListenerBloc extends Bloc<TextListenerEvent, TextListenerState> {
  TextListenerBloc() : super(TextListenerInitState()) {
    on<TextAddListenerEvent>(_textAddListener);
  }

  void _textAddListener(
      TextAddListenerEvent event, Emitter<TextListenerState> state) {
    logger.e(event.text);
  }
}
