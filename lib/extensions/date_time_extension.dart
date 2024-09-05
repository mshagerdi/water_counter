extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime dateCriterion) =>
      year == dateCriterion.year &&
      month == dateCriterion.month &&
      day == dateCriterion.day;
}
