# cell_calendar

[![pub package](https://img.shields.io/pub/v/cell_calendar.svg)](https://pub.dev/packages/cell_calendar)
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>

**Modern calendar widget with useful features. Enables to develop well designed calendar in a moment.**

**Inspired by the UI of Google Calendar**

![cell_calendar](https://user-images.githubusercontent.com/43510799/92649244-ae30e180-f325-11ea-92a8-3e21d76aacd8.gif)

## Usage

- **Events**

You can show the events in the calendar by inserting the list of CalendarEvent as `events`
```dart
    CellCalendar(
      events: [
        CalendarEvent(eventName: "Event 1",eventDate: DateTime1),
        CalendarEvent(eventName: "Event 2",eventDate: DateTime2),
      ]
    );
```

If you need to customize the calendar more, the additional parameters like `eventBackGroundColor`, `eventTextColor` and `eventID` are helpful.


- **onPageChanged**

The callback `onPageChanged` is literally called when the current page is changed.
```dart
    CellCalendar(
      onPageChanged: (firstDate, lastDate) {
        print("This is the first date of the new page: $firstDate");
        print("This is the last date of the new page: $lastDate");
      }
    );
```
In this sample code, `firstDate` is the date in the very first cell of the new page, and its logic is same as `lastDate`.

- **onCellTapped**

The callback `onCellTapped` is called when user tapped a cell.
```dart
    CellCalendar(
      onCellTapped: (date) {
        print("$date is tapped !");
      }
    );
```
It is called with tapped DateTime, so you can get the events on the date if you want.
```dart
    CellCalendar(
      onCellTapped: (date){
        print("$date is tapped !");
        final eventsOnTheDate = sampleEvents().where((event) {
          final eventDate = event.eventDate;
          return eventDate.year == date.year &&
              eventDate.month == date.month &&
              eventDate.day == date.day;
        }).toList();
        /// ex) Show dialog or navigate to new page with [eventsOnTheDate]
      }
    );

```

- **daysOfTheWeekBuilder and monthYearLabelBuilder**

If you don't want to use default labels on the calendar, you can use callbacks for customization.
```dart
    CellCalendar(
      daysOfTheWeekBuilder: (dayIndex) {
        /// dayIndex: 0 for Sunday, 6 for Saturday.
        final labels = ["S", "M", "T", "W", "T", "F", "S"];
        return Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            labels[dayIndex],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
      monthYearLabelBuilder: (datetime) {
        final year = datetime.year.toString();
        final month = datetime.month.toString();
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "$month, $year",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    )
```





If you have any requests or questions, please feel free to ask on [github](https://github.com/santa112358/cell_calendar/issues).

