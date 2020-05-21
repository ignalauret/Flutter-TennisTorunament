bool isSameDay(DateTime day1, DateTime day2) {
  return day1.year == day2.year &&
      day1.month == day2.month &&
      day1.day == day2.day;
}

DateTime parseDate(String date) {
  final list = date.split("/");
  return DateTime(
    int.parse(list[2]),
    int.parse(list[1]),
    int.parse(list[0]),
  );
}
