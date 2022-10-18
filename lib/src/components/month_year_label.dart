import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Label showing the date of current page
class MonthYearLabel extends HookConsumerWidget {
  const MonthYearLabel(
    this.monthYearLabelBuilder, {
    Key? key,
  }) : super(key: key);

  final MonthYearBuilder? monthYearLabelBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDateTime = ref.watch(currentDateProvider);
    final monthLabel = currentDateTime.month.monthName;
    final yearLabel = currentDateTime.year.toString();
    return monthYearLabelBuilder?.call(currentDateTime) ??
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Text(
            monthLabel + " " + yearLabel,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
  }
}
