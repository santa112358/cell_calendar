import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/calendar_state_controller.dart';
import '../../controllers/cell_height_controller.dart';
import 'event_labels.dart';
import 'measure_size.dart';

/// Show the row of [_DayCell] cells with events
class DaysRow extends StatelessWidget {
  const DaysRow({
    @required this.visiblePageDate,
    @required this.dates,
    Key key,
  }) : super(key: key);

  final List<DateTime> dates;
  final DateTime visiblePageDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: dates.map((date) {
          return _DayCell(date, visiblePageDate);
        }).toList(),
      ),
    );
  }
}

/// Cell of calendar.
///
/// Its height is circulated by [MeasureSize] and notified by [CellHeightController]
class _DayCell extends StatelessWidget {
  _DayCell(this.date, this.visiblePageDate);

  final DateTime date;
  final DateTime visiblePageDate;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Provider.of<CalendarStateController>(context, listen: false)
              .onCellTapped(date);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor, width: 1),
              right:
                  BorderSide(color: Theme.of(context).dividerColor, width: 1),
            ),
          ),
          child: MeasureSize(
            onChange: (size) {
              Provider.of<CellHeightController>(context, listen: false)
                  .onChanged(size);
            },
            child: Column(
              children: [
                isToday
                    ? _TodayDayLabel(date: date)
                    : _DayLabel(date: date, visiblePageDate: visiblePageDate),
                EventLabels(date),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TodayDayLabel extends StatelessWidget {
  const _TodayDayLabel({
    Key key,
    @required this.date,
  }) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<TodayUIConfig>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: config.todayMarkColor,
      ),
      child: Center(
        child: Text(
          date.day.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: config.todayTextColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _DayLabel extends StatelessWidget {
  const _DayLabel({
    Key key,
    @required this.date,
    @required this.visiblePageDate,
  }) : super(key: key);

  final DateTime date;
  final DateTime visiblePageDate;

  @override
  Widget build(BuildContext context) {
    final isCurrentMonth = visiblePageDate.month == date.month;
    final colorScheme = Theme.of(context).textTheme.bodyText1.color;
    return Container(
      margin: EdgeInsets.symmetric(vertical: dayLabelVerticalMargin.toDouble()),
      height: dayLabelContentHeight.toDouble(),
      child: Text(
        date.day.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isCurrentMonth ? colorScheme : colorScheme.withOpacity(0.4)),
      ),
    );
  }
}
