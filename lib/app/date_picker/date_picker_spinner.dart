import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DatePickerSpinner extends StatefulWidget {
  final double? height;
  final double? width;
  final int? interval;
  final DateTime date;
  final Function(String) onChanged;
  const DatePickerSpinner({
    super.key,
    this.height,
    this.width,
    this.interval,
    required this.date,
    required this.onChanged,
  });

  @override
  State<DatePickerSpinner> createState() => _DatePickerSpinnerState();
}

class _DatePickerSpinnerState extends State<DatePickerSpinner> {
  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;
  List<String> _year = [];
  final List<String> _month = List.generate(
      12, (index) => index < 9 ? "0${index + 1}" : "${index + 1}");
  List<String> _day = [];
  late double _width;
  late double _height;
  late Size _itemSize;
  late ValueNotifier<String> currentDate;

  @override
  void initState() {
    currentDate = ValueNotifier(
        widget.date.toString().replaceAll("-", "").substring(0, 8));
    _width = widget.width ?? MediaQuery.of(context).size.width;
    _height = widget.height ?? 300;
    _itemSize = Size(_width / 3, _height);
    int _currentYear = DateTime.now().year;
    _year = List.generate(
        widget.interval == null || widget.interval == 0
            ? 100
            : widget.interval!,
        (index) => widget.interval == null || widget.interval! < 1
            ? "${index + (_currentYear - 50)}"
            : "${index + (_currentYear - (widget.interval == 1 ? 0 : widget.interval! ~/ 2))}");
    _daySetting(true);
    int _initialYear = _year.indexOf(currentDate.value.substring(0, 4));
    int _initialMonth = _month.indexOf(currentDate.value.substring(4, 6));
    int _initialDay = _day.indexOf(currentDate.value.substring(6, 8));
    _yearController = FixedExtentScrollController(initialItem: _initialYear);
    _monthController = FixedExtentScrollController(initialItem: _initialMonth);
    _dayController = FixedExtentScrollController(initialItem: _initialDay);
    super.initState();
  }

  void _changedDate(int dateType, int index) {
    String _currentYear = currentDate.value.substring(0, 4);
    String _currentMonth = currentDate.value.substring(4, 6);
    String _currentDay = currentDate.value.substring(6, 8);

    switch (dateType) {
      case 0:
        currentDate.value = _year[index] + _currentMonth + _currentDay;
        if (_currentMonth == "02") {
          _leapYearChecked();
        }
        break;
      case 1:
        currentDate.value = _currentYear + _month[index] + _currentDay;
        _daySetting(false);
        break;
      case 2:
        currentDate.value = _currentYear + _currentMonth + _day[index];
        break;
      default:
    }
  }

  void _daySetting(bool initial) {
    int _month = int.parse(currentDate.value.substring(4, 6));
    List _thiryFirst = [1, 3, 5, 7, 8, 10, 12];
    int _selectedDayItem = !initial ? _dayController.selectedItem : 0;
    if (_thiryFirst.contains(_month)) {
      _day = List.generate(
          31, (index) => index < 9 ? "0${index + 1}" : "${index + 1}");
    } else if (_month == 2) {
      _leapYearChecked();
      if (_day.length <= _selectedDayItem) {
        _dayController.jumpToItem(_day.length - 1);
      }
    } else {
      _day = List.generate(
          30, (index) => index < 9 ? "0${index + 1}" : "${index + 1}");
      if (_selectedDayItem == 30) {
        _dayController.jumpToItem(29);
      }
    }
  }

  void _leapYearChecked() {
    int _dayLength = 0;
    int _year = int.parse(currentDate.value.substring(0, 4));
    if (((_year % 4 == 0) && (_year % 100 != 0)) || (_year % 400 == 0)) {
      _dayLength = 29;
    } else {
      _dayLength = 28;
    }
    _day = List.generate(
        _dayLength, (index) => index < 9 ? "0${index + 1}" : "${index + 1}");
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: currentDate,
        builder: (context, value, child) {
          return Container(
            height: _height,
            width: _width,
            color: const Color.fromRGBO(71, 71, 71, 1),
            child: Wrap(
              children: [
                _pickerForm(
                    controller: _yearController,
                    date: _year,
                    dateIndex: 0,
                    current: value.substring(0, 4)),
                _pickerForm(
                    controller: _monthController,
                    date: _month,
                    dateIndex: 1,
                    current: value.substring(4, 6)),
                _pickerForm(
                    controller: _dayController,
                    date: _day,
                    dateIndex: 2,
                    current: value.substring(6, 8)),
              ],
            ),
          );
        });
  }

  SizedBox _pickerForm({
    required List<String> date,
    required int dateIndex,
    required String current,
    required FixedExtentScrollController controller,
  }) {
    return SizedBox(
      height: _itemSize.height,
      width: _itemSize.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ListWheelScrollView(
          controller: controller,
          onSelectedItemChanged: (int i) {
            HapticFeedback.lightImpact();
            _changedDate(dateIndex, i);
            widget.onChanged(currentDate.value);
          },
          squeeze: 0.6,
          perspective: 0.00001,
          physics: const FixedExtentScrollPhysics(),
          itemExtent: 30,
          children: [
            ...List.generate(
                date.length,
                (index) => Text(
                      date[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: date[index] == current ? 12 : 11,
                        color: date[index] == current
                            ? Colors.white
                            : Colors.white54,
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
