const int initialPageIndex = 1200;

extension DateExtension on int {
  int get fromInitialIndex {
    return this - 1200;
  }

  Duration get daysDuration {
    return Duration(days: (this == 7) ? 0 : -this);
  }

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

  DateTime get currentDateTime {
    final monthDif = this - 1200;
    final currentYear = _currentYear(monthDif);
    final currentMonth = _currentMonth(monthDif);
    return DateTime(currentYear, currentMonth);
  }

  int _currentYear(int monthDif) {
    final initialMonth = DateTime.now().month;
    final initialYear = DateTime.now().year;
    final res = initialMonth + monthDif;
    if (res > 0) {
      return initialYear + (res ~/ 12);
    } else {
      return initialYear + ((res ~/ 12) - 1);
    }
  }

  int _currentMonth(int monthDif) {
    final initialMonth = DateTime.now().month;
    final res = initialMonth + monthDif;
    if (res > 0) {
      return res % 12;
    } else {
      return 12 - (-res % 12);
    }
  }
}
