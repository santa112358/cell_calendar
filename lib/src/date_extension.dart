/// Initial index for pageView of calendar
///
/// User can get back to maximum 100 year and 1 month.
const int initialPageIndex = 1200;

/// Extension to show accurate date in the calendar by current index of pageView
extension DateExtension on int {
  int get fromInitialIndex {
    return this - 1200;
  }

  Duration get daysDuration {
    return Duration(days: (this == 7) ? 0 : -this);
  }

  /// MonthName for the number of month
  String get monthName {
    switch (this) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
    }
    assert(false, "UNEXPECTED MONTH");
    return "";
  }

  /// Return year and month to be shown by the currentIndex of pageView
  DateTime get visibleDateTime {
    final monthDif = this - 1200;
    final visibleYear = _visibleYear(monthDif);
    final visibleMonth = _visibleMonth(monthDif);
    return DateTime(visibleYear, visibleMonth);
  }

  int _visibleYear(int monthDif) {
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;
    final visibleMonth = currentMonth + monthDif;

    /// When visible month is in the current year or future year
    if (visibleMonth > 0) {
      return currentYear + (visibleMonth ~/ 12);

      /// When visible month is in the past year
    } else {
      return currentYear + ((visibleMonth ~/ 12) - 1);
    }
  }

  int _visibleMonth(int monthDif) {
    final initialMonth = DateTime.now().month;
    final currentMonth = initialMonth + monthDif;

    /// When visible month is in the current year or future year
    if (currentMonth > 0) {
      return currentMonth % 12;

      /// When visible month is in the past year
    } else {
      return 12 - (-currentMonth % 12);
    }
  }
}
