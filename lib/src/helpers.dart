import 'package:finance/src/constants.dart';

buildDateText(transactionDate) {
  final date = transactionDate;

  if (date == null) {
    return '';
  }

  return '${Constants.months[date.month]} ${date.day}, ${date.year}';
}
