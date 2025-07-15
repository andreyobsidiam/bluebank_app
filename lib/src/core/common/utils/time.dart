class TimeOfDayHelper {
  static String getPeriod(DateTime time) {
    final hour = time.hour;

    return switch (hour) {
      (>= 6 && < 12) => 'morning',
      (>= 12 && < 18) => 'afternoon',
      _ => 'evening',
    };
  }
}
