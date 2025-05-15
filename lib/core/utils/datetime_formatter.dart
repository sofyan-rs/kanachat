import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String formatDateTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      DateFormat formatter = DateFormat('hh:mm a');
      return formatter.format(date);
    } else {
      DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');
      return formatter.format(date);
    }
  }
}
