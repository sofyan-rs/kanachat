import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formatDateTime {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays == 0) {
      DateFormat formatter = DateFormat('hh:mm a');
      return formatter.format(this);
    } else {
      DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');
      return formatter.format(this);
    }
  }
}
