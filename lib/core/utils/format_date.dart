import 'package:intl/intl.dart';

String formatDateBydMMMMyyyy(DateTime? dateTime) {
  if(dateTime==null) return '';
  return DateFormat("d MMM, yyy").format(dateTime);
}
