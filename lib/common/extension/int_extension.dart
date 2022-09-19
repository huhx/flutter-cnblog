import 'package:intl/intl.dart';

extension IntExtension on int {
  String toDateString({String dateFormat = "yyyy-MM-dd"}) {
    return DateFormat(dateFormat).format(DateTime.fromMillisecondsSinceEpoch(this));
  }
}
