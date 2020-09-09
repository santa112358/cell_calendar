import 'dart:html';

import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'cell_calendar example'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  List<CalendarEvent> sampleEvents() {
    final today = DateTime.now();
    return [
      CalendarEvent(eventName: "Task Deadline", eventDate: today),
      CalendarEvent(
          eventName: "Jon's Birthday", eventDate: today.add(Duration(days: 3))),
      CalendarEvent(
          eventName: "Date with Rebecca",
          eventDate: today.add(Duration(days: 7)),
          eventBackgroundColor: Colors.pink),
      CalendarEvent(
          eventName: "Start to study Spanish",
          eventDate: today.add(Duration(days: 30)))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CellCalendar(
        events: sampleEvents(),
        onCellTapped: (tappedDate) {
          final eventsOnTheDate = sampleEvents().where((event) {
            final eventDate = event.eventDate;
            return eventDate.year == tappedDate.year &&
                eventDate.month == tappedDate.month &&
                eventDate.day == tappedDate.day;
          }).toList();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(
                tappedDate.month.toString() + " " + tappedDate.year.toString(),
              ),
              content: Column(
                children: eventsOnTheDate
                    .map((event) => Text(event.eventName))
                    .toList(),
              ),
            ),
          );
        },
        onPageChanged: (firstDate, lastDate){
          /// Called when the page was changed
          /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want

        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
