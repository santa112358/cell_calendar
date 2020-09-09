import 'package:flutter/material.dart';

/// Days of the week
///
// TODO: Internationalize the days of the week
const List<String> _DaysOfTheWeek = [
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fry',
  'Sat'
];

class DaysOfTheWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: _DaysOfTheWeek.map((day) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              day,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }
}
