import 'dart:developer';

import 'package:intl/intl.dart';

class DateTimeService {
  DateTimeService._privateConstructor();

  static DateTimeService? _instance;

  static DateTimeService get instance {
    _instance ??= DateTimeService._privateConstructor();
    return _instance!;
  }

  // Month Year e.g ("January 2024")

  String getMonthYearFormat(DateTime date) {
    String month = DateFormat('MMMM').format(date);
    String year = DateFormat('yyyy').format(date);
    return '$month $year';
  }

  // Format date as "dd EEEE" (e.g., "16 Tue")

  String formatDateWithDay(DateTime dateTime) {
    return DateFormat('dd E').format(dateTime);
  }

  // simple format date picker
  // 10 jan 2025
  String getSimpleUSDateFormat(DateTime date) {
    // Formatting the day
    String day = DateFormat('d').format(date);
    // Formatting the month as a three-letter abbreviation
    String month = DateFormat('MMM').format(date);
    // Formatting the year
    String year = DateFormat('yyyy').format(date);

    return '$day $month $year';
  }

  // Date in US format
  // Oct 25 21

  String getDateUsFormat(DateTime date) {
    // Formatting the month as a three-letter abbreviation
    String month = DateFormat('MMM').format(date);
    // Formatting the day with suffix (st, nd, rd, th)
    String day = date.day.toString() + getDaySuffix(date.day);
    // Formatting the year
    String year = DateFormat('yyyy').format(date);

    return '$month $day, $year';
  }

  // Date in ISO format
  //YYYY-MM-DD
  //2025-10-30

  String getDateIsoFormat(DateTime date) {
    // Formatting the date in ISO 8601 format (YYYY-MM-DD)
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  // Time in AM & PM format

  // String formatTimeToAMPM(time) {
  //   if (time != null) {
  //     final finalTime = DateFormat('hh:mm a').format(time);
  //     return finalTime;
  //   } else {
  //     log('Time is $time');
  //     return '';
  //   }
  // }

  String formatTimeToAMPMTakingAsDateTime(DateTime dateTime) {
    try {
      // Format only the time part to 'hh:mm a'
      final formattedTime = DateFormat('hh:mm a').format(dateTime);
      return formattedTime;
    } catch (e) {
      log('Error formatting DateTime "$dateTime": $e');
      return '';
    }
  }

  // --------- Pass time as String -------
  String formatTimeToAMPM(String timeString) {
    try {
      // Example input: "07:55:48.686687"
      final time = DateFormat("HH:mm:ss.SSSSSS").parse(timeString);
      final formattedTime = DateFormat('hh:mm a').format(time);
      return formattedTime;
    } catch (e) {
      log('Error parsing time string "$timeString": $e');
      return '';
    }
  }

  String formatDateTimeFromString(String dateTimeString) {
    try {
      // Parse input like "2025-06-17T07:55:48.686687"
      final DateTime dateTime = DateTime.parse(dateTimeString);

      // Format date and time separately
      final formattedDate = DateFormat(
        'MMMM d, y',
      ).format(dateTime); // June 17, 2025
      final formattedTime = DateFormat('hh:mm a').format(dateTime); // 07:55 AM

      return '$formattedDate • $formattedTime';
    } catch (e) {
      log('Error parsing datetime string "$dateTimeString": $e');
      return '';
    }
  }

  String formatDateTimeForApi(DateTime dateTime) {
    try {
      // Converts to 'YYYY-MM-DDTHH:MM:SS.mmmmmm' (ISO 8601)
      return dateTime.toIso8601String();
    } catch (e) {
      log('Error formatting DateTime "$dateTime": $e');
      return '';
    }
  }

  /*
  Format event date like... 
  "12:00 am | June 23, 2025"
   */

  String formatEventDateTime(DateTime dateTime) {
    final time = DateFormat('h:mm a').format(dateTime); // e.g. 12:00 AM
    final date = DateFormat('MMMM d, y').format(dateTime); // e.g. June 23, 2025
    return '$time | $date';
  }
}
