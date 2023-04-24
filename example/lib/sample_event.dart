import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';

List<CalendarEvent> sampleEvents() {
  final today = DateTime.now();
  const eventTextStyle = TextStyle(
    fontSize: 9,
    color: Colors.white,
  );
  final sampleEvents = [
    CalendarEvent(
      eventName: "New iPhone",
      eventDate: today.add(const Duration(days: -42)),
      eventBackgroundColor: Colors.black,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Writing test",
      eventDate: today.add(const Duration(days: -30)),
      eventBackgroundColor: Colors.deepOrange,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Play soccer",
      eventDate: today.add(const Duration(days: -7)),
      eventBackgroundColor: Colors.greenAccent,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Learn about history",
      eventDate: today.add(
        const Duration(days: -7),
      ),
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Buy new keyboard",
      eventDate: today.add(
        const Duration(days: -7),
      ),
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Walk around the park",
      eventDate: today.add(const Duration(days: -7)),
      eventBackgroundColor: Colors.deepOrange,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Buy a present for Rebecca",
      eventDate: today.add(const Duration(days: -7)),
      eventBackgroundColor: Colors.pink,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Firebase",
      eventDate: today.add(
        const Duration(days: -7),
      ),
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Task deadline",
      eventDate: today,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Jon's Birthday",
      eventDate: today.add(
        const Duration(days: 3),
      ),
      eventBackgroundColor: Colors.green,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Date with Rebecca",
      eventDate: today.add(const Duration(days: 7)),
      eventBackgroundColor: Colors.pink,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Start to study Spanish",
      eventDate: today.add(
        const Duration(days: 13),
      ),
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Have lunch with Mike",
      eventDate: today.add(const Duration(days: 13)),
      eventBackgroundColor: Colors.green,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Buy new Play Station software",
      eventDate: today.add(const Duration(days: 13)),
      eventBackgroundColor: Colors.indigoAccent,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Update my flutter package",
      eventDate: today.add(
        const Duration(days: 13),
      ),
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Watch movies in my house",
      eventDate: today.add(
        const Duration(days: 21),
      ),
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Medical Checkup",
      eventDate: today.add(const Duration(days: 30)),
      eventBackgroundColor: Colors.red,
      eventTextStyle: eventTextStyle,
    ),
    CalendarEvent(
      eventName: "Gym",
      eventDate: today.add(const Duration(days: 42)),
      eventBackgroundColor: Colors.indigoAccent,
      eventTextStyle: eventTextStyle,
    ),
  ];
  return sampleEvents;
}
