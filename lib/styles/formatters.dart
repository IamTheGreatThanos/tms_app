import 'package:europharm_flutter/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Formatters {
  static String mainTime(DateTime dateTime) {
    return DateFormat("hh:mm a").format(dateTime.toLocal());
  }

  static String callsScheduledDateTime(DateTime dateTime) {
    return DateFormat(r'''MMM d 'at' hh:mm a''').format(dateTime.toLocal());
  }

  static String callsDateTime(DateTime dateTime) {
    return DateFormat("MMM d, hh:mm a").format(dateTime.toLocal());
  }

  //
  // static String sessionDateFormatterFile(DateTime dateTime) {
  //   return DateFormat('MMM dd, yy, hh:mm a').format(dateTime);
  // }
  //
  static String mainDateAndTime(DateTime dateTime) {
    return DateFormat('MM/dd/yy, hh:mm a').format(dateTime.toLocal());
  }

  static String mainOnlyDate(DateTime dateTime) {
    return DateFormat('MM/dd/yy').format(dateTime.toLocal());
  }

  //
  // static DateFormat bDayFormatter = DateFormat('MMM dd, yyyy');
  static MaskTextInputFormatter phoneFormatter = MaskTextInputFormatter(
    mask: '+1 ### ### ####',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  static String scheduleDayOfWeek(DateTime dateTime) {
    return DateFormat('EEE').format(dateTime.toLocal());
  }

  static String scheduleMonthYear(DateTime dateTime) {
    return DateFormat('MMM yyyy').format(dateTime.toLocal());
  }

  static String scheduleMonthDayYear(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy').format(dateTime.toLocal());
  }

  static String nameFormatter(String? lastName, String? firstName, S lang) {
    final name = ((lastName ?? '') + ' ' + (firstName ?? '')).trim();
    if (name.isNotEmpty) return name;
    return lang.no_data;
  }
}
