import 'package:shared_preferences/shared_preferences.dart';

class WaterCounterPreferences {
  static const DRUNK_WATER_AMOUNT = 'DRUNKWATERAMOUNT';
  static const GLASS_CAPACITY = 'GLASSCAPACITY';
  static const DAILY_WATER_AMOUNT = 'DAILYWATERAMOUNT';

  saveDrunkAmount(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(DRUNK_WATER_AMOUNT, value);
  }

  Future<double> loadDrunkAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(DRUNK_WATER_AMOUNT) ?? 0.0;
  }

  saveGlassCapacity(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(GLASS_CAPACITY, value);
  }

  Future<double> loadGlassCapacity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(GLASS_CAPACITY) ?? 125.0;
  }

  saveDailyAmount(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(DAILY_WATER_AMOUNT, value);
  }

  Future<double> loadDailyAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(DAILY_WATER_AMOUNT) ?? 2500.0;
  }
}
