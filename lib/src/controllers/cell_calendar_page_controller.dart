import 'package:cell_calendar/src/date_extension.dart';
import 'package:flutter/material.dart';

class CellCalendarPageController extends PageController {
  CellCalendarPageController() : super(initialPage: initialPageIndex);

  void jumpToDate(DateTime date) {
    final currentDate = DateTime.now();
    final monthDif =
        (date.year - currentDate.year) * 12 + (date.month - currentDate.month);
    super.jumpToPage(initialPageIndex + monthDif);
  }

  void animateToDate(
    DateTime date, {
    @required Duration duration,
    @required Curve curve,
  }) {
    final currentDate = DateTime.now();
    final monthDif =
        (date.year - currentDate.year) * 12 + (date.month - currentDate.month);
    super.animateToPage(initialPageIndex + monthDif,
        duration: duration, curve: curve);
  }
}
