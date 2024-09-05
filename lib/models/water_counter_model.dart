import 'package:objectbox/objectbox.dart';
import 'package:intl/intl.dart';

@Entity()
class WaterCounterModel {
  int id;
  double amount;
  DateTime date;

  WaterCounterModel(this.amount, {this.id = 0, DateTime? dateTime})
      : date = dateTime ?? DateTime.now();

  String get dateFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(date);

  double setAmount(double newAmount) => amount = newAmount;
}
