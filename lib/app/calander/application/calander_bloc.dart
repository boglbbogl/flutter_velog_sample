import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_velog_sample/app/calander/application/calander_event.dart';
import 'package:flutter_velog_sample/app/calander/application/calander_state.dart';
import 'package:flutter_velog_sample/app/calander/model/calander_model.dart';
import 'package:intl/intl.dart';

class CalanderBloc extends Bloc<CalanderEvent, CalanderState> {
  CalanderBloc()
      : super(CalanderState(
            calander: CalanderModel.empty(), currentDate: DateTime.now())) {
    on<CalanderStartEvent>(_start);
    on<CalanderChangeEvent>(_change);
    on<CalanderUpdateBlurEvent>(_updateBlur);
    on<CalanderEndBlurEvent>(_endBlur);
    add(CalanderStartEvent());
  }

  Future<void> _endBlur(
      CalanderEndBlurEvent event, Emitter<CalanderState> emit) async {
    bool _isNext = event.endDetails.primaryVelocity! < 0;
    emit(state.copyWith(blur: 0.0));
    add(CalanderChangeEvent(isNext: _isNext));
  }

  Future<void> _updateBlur(
      CalanderUpdateBlurEvent event, Emitter<CalanderState> emit) async {
    double _blur = state.blur;
    double _dx = 0.0;
    if (event.updateDetails.delta.dx > 0) {
      _dx = event.updateDetails.delta.dx / 70;
    } else {
      _dx = -(event.updateDetails.delta.dx) / 70;
    }
    _blur = _dx + _blur > 0.5 ? 0.5 : _dx + _blur;
    emit(state.copyWith(blur: _blur));
  }

  Future<void> _change(
      CalanderChangeEvent event, Emitter<CalanderState> emit) async {
    int _index = event.isNext ? 1 : -1;
    DateTime _dateTime =
        DateTime(state.currentDate.year, state.currentDate.month + _index);
    List<int> _day = _days(_dateTime);
    emit(state.copyWith(
        currentDate: _dateTime,
        calander: state.calander.copyWith(
            year: _dateTime.year, month: _dateTime.month, days: _day)));
  }

  Future<void> _start(
      CalanderStartEvent event, Emitter<CalanderState> emit) async {
    DateTime _dateTime = event.datTime ?? DateTime.now();
    List<int> _day = _days(_dateTime);
    emit(state.copyWith(
        calander: state.calander.copyWith(
            year: _dateTime.year, month: _dateTime.month, days: _day)));
  }

  List<int> _days(DateTime dateTime) {
    int _dayLenght = _daysLengthChecked(dateTime);
    int _frontSpaces = _spaceDays(
        type: DateFormat('EEEE')
            .format(DateTime(dateTime.year, dateTime.month, 1)));
    int _rearSpaces = _spaceDays(
        type: DateFormat('EEEE')
            .format(DateTime(dateTime.year, dateTime.month, _dayLenght)),
        isLast: true);

    List<int> _days = [
      ...List.generate(_frontSpaces, (_) => 0),
      ...List.generate(_dayLenght, (index) => index + 1),
      ...List.generate(_rearSpaces, (_) => 0),
    ];
    return _days;
  }

  int _spaceDays({
    required String type,
    bool isLast = false,
  }) {
    int _spaceLength = 0;
    switch (type) {
      case "Monday":
        _spaceLength = isLast ? 5 : 1;
        break;
      case "Tuesday":
        _spaceLength = isLast ? 4 : 2;
        break;
      case "Wednesday":
        _spaceLength = isLast ? 3 : 3;
        break;
      case "Thursday":
        _spaceLength = isLast ? 2 : 4;
        break;
      case "Friday":
        _spaceLength = isLast ? 1 : 5;
        break;
      case "Saturday":
        _spaceLength = isLast ? 0 : 6;
        break;
      case "Sunday":
        _spaceLength = isLast ? 6 : 0;
        break;
      default:
    }
    return _spaceLength;
  }

  int _daysLengthChecked(DateTime dateTime) {
    int _dayLength = 0;
    List _thiryFirst = [1, 3, 5, 7, 8, 10, 12];

    if (dateTime.month == 2) {
      if (((dateTime.year % 4 == 0) && (dateTime.year % 100 != 0)) ||
          (dateTime.year % 400 == 0)) {
        _dayLength = 29;
      } else {
        _dayLength = 28;
      }
    } else {
      _dayLength = _thiryFirst.contains(dateTime.month) ? 31 : 30;
    }
    return _dayLength;
  }

  @override
  void onChange(Change<CalanderState> change) {
    super.onChange(change);
  }
}
