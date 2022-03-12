// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeConverters {
  static DateTime dateTimeAsIs(DateTime? dateTime) => dateTime as DateTime;

  static DateTime dateTimeFromTimestamp(Timestamp timestamp) {
    return DateTime.parse(timestamp.toDate().toString());
  }
}
