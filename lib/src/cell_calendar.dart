import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calendar_event.dart';
import 'components/days_of_the_week.dart';
import 'components/days_row/days_row.dart';
import 'components/month_year_label.dart';
import 'controllers/calendar_month_controller.dart';
import 'controllers/calendar_state_controller.dart';
import 'controllers/cell_height_controller.dart';
import 'date_extension.dart';

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
  });

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
            todayMarkColor: todayMarkColor,
            todayTextColor: todayTextColor,
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
                return _CalendarPage.wrapped(index.visibleDateTime);
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
  const _CalendarPage._({
    Key key,
  }) : super(key: key);

  static Widget wrapped(DateTime currentPageDate) {
    return ChangeNotifierProvider(
      create: (_context) => CalendarMonthController(currentPageDate),
      child: _CalendarPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CalendarMonthController>(context);
    final days = controller.currentDays;
    return Column(
      children: [
        DaysOfTheWeek(),
        DaysRow(dates: days.getRange(0, 7).toList()),
        DaysRow(dates: days.getRange(7, 14).toList()),
        DaysRow(dates: days.getRange(14, 21).toList()),
        DaysRow(dates: days.getRange(21, 28).toList()),
        DaysRow(dates: days.getRange(28, 35).toList()),
        DaysRow(dates: days.getRange(35, 42).toList()),
      ],
    );
  }
}
