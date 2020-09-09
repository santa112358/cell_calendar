import 'package:flutter/material.dart';

import '../date_extension.dart';

extension _DaysDuration on int {}

/// Controller to circulate and show the days of the current page
class CalendarMonthController extends ChangeNotifier {
  CalendarMonthController(this.currentPageDate) {
    this._initialize();
  }
  final DateTime currentPageDate;

  List<DateTime> currentDays = [];
  void _initialize() {
    currentDays = _getCurrentDays(currentPageDate);
  }

  List<DateTime> _getCurrentDays(DateTime dateTime) {
    final List<DateTime> result = [];
    final firstDay = _getFirstDay(dateTime);
    result.add(firstDay);
    for (int i = 0; i + 1 < 42; i++) {
      result.add(firstDay.add(Duration(days: i + 1)));
    }
    return result;
  }

  DateTime _getFirstDay(DateTime dateTime) {
    final firstDayOfTheMonth = DateTime(dateTime.year, dateTime.month, 1);
    return firstDayOfTheMonth.add(firstDayOfTheMonth.weekday.daysDuration);
  }
}
