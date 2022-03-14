// ignore_for_file: file_names

int getExpiryWeeks({required DateTime date}) {
  date = DateTime(date.year, date.month, date.day);
  DateTime now = DateTime.now();
  DateTime currentTime = DateTime(now.year, now.month, now.day);

  int days = (currentTime.difference(date).inHours / 24).round();
  int weeks = (days / 7).round();
  return weeks;
}
