extension StringExtensions on DateTime {
  DateTime fromTime(String time) {
    return DateTime.parse('2000-01-01T$time.000000');
  }
}

