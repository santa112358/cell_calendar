import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calendar_event.dart';
import 'components/days_of_the_week.dart';
import 'components/days_row/days_row.dart';
import 'components/month_year_label.dart';
import 'controllers/calendar_state_controller.dart';
import 'controllers/cell_height_controller.dart';
import 'date_extension.dart';

typedef daysOfTheWeekBuilder = Widget Function(int index);

class TodayUIConfig {
  final Color todayMarkColor;
  final Color todayTextColor;

  TodayUIConfig(this.todayTextColor, this.todayMarkColor);
}

/// Calendar widget like a Google Calendar
///
/// Expected to be used in full screen
class CellCalendar extends StatelessWidget {
  CellCalendar({
    this.events = const [],
    this.onPageChanged,
    this.onCellTapped,
    this.todayMarkColor = Colors.blue,
    this.todayTextColor = Colors.white,
    this.daysOfTheWeekBuilder,
  });

  final Widget Function(int index) daysOfTheWeekBuilder;
  final List<CalendarEvent> events;
  final void Function(DateTime firstDate, DateTime lastDate) onPageChanged;
  final void Function(DateTime) onCellTapped;
  final Color todayMarkColor;
  final Color todayTextColor;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CalendarStateController(
            events: events,
            onPageChangedFromUserArgument: onPageChanged,
            onCellTappedFromUserArgument: onCellTapped,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CellHeightController(),
        ),
        Provider.value(value: TodayUIConfig(todayTextColor, todayMarkColor)),
      ],
      child: _CalendarPageView(),
    );
  }
}

/// Shows [MonthYearLabel] and PageView of [_CalendarPage]
class _CalendarPageView extends StatelessWidget {
  _CalendarPageView();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MonthYearLabel(),
        Expanded(
          child: PageView.builder(
              controller: PageController(initialPage: 1200),
              itemBuilder: (context, index) {
                return _CalendarPage(index.visibleDateTime);
              },
              onPageChanged: (index) {
                Provider.of<CalendarStateController>(context, listen: false)
                    .onPageChanged(index);
              }),
        ),
      ],
    );
  }
}

/// Page of [_CalendarPage]
///
/// Wrapped with [CalendarMonthController]
class _CalendarPage extends StatelessWidget {
  const _CalendarPage(
    this.visiblePageDate, {
    Key key,
  }) : super(key: key);

  final DateTime visiblePageDate;

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

  @override
  Widget build(BuildContext context) {
    final days = _getCurrentDays(visiblePageDate);
    return Column(
      children: [
        DaysOfTheWeek(),
        DaysRow(
          dates: days.getRange(0, 7).toList(),
          visiblePageDate: visiblePageDate,
        ),
        DaysRow(
          dates: days.getRange(7, 14).toList(),
          visiblePageDate: visiblePageDate,
        ),
        DaysRow(
          dates: days.getRange(14, 21).toList(),
          visiblePageDate: visiblePageDate,
        ),
        DaysRow(
          dates: days.getRange(21, 28).toList(),
          visiblePageDate: visiblePageDate,
        ),
        DaysRow(
          dates: days.getRange(28, 35).toList(),
          visiblePageDate: visiblePageDate,
        ),
        DaysRow(
          dates: days.getRange(35, 42).toList(),
          visiblePageDate: visiblePageDate,
        ),
      ],
    );
  }
}
