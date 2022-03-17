import 'package:intl/intl.dart';

String formattedDate({required DateTime date}) {
  var formatDate = DateFormat.yMMMMd();

  String formattedDate = formatDate.format(date);

  var formatTime = DateFormat.Hm();

  String formattedTime = formatTime.format(date);

  return "$formattedDate, $formattedTime";
}
