import 'package:flutter/foundation.dart';
import 'package:water_counter/components/water_counter_preferences.dart';

class WaterCounterProvider with ChangeNotifier {
  WaterCounterPreferences waterCounterPreferences = WaterCounterPreferences();

  double _drunkWaterAmount = 0;
  double _glassCapacity = 125;
  double _dailyWaterAmount = 2500;

  double get drunkWaterAmount => _drunkWaterAmount;

  double get glassCapacity => _glassCapacity;

  double get dailyWaterAmount => _dailyWaterAmount;

  set drunkWaterAmount(double value) {
    _drunkWaterAmount = value;
    waterCounterPreferences.saveDrunkAmount(value);
    notifyListeners();
  }

  set glassCapacity(double value) {
    _glassCapacity = value;
    waterCounterPreferences.saveGlassCapacity(value);
    notifyListeners();
  }

  set dailyWaterAmount(double value) {
    _dailyWaterAmount = value;
    notifyListeners();
    waterCounterPreferences.saveDailyAmount(value);
  }

  void decreaseGlassCapacity() {
    if (_glassCapacity > 25) {
      _glassCapacity -= 25;
      notifyListeners();
      waterCounterPreferences.saveGlassCapacity(_glassCapacity);
    }
  }

  void increaseGlassCapacity() {
    _glassCapacity += 25;
    notifyListeners();
    waterCounterPreferences.saveGlassCapacity(_glassCapacity);
  }

  void decreaseDailyAmount() {
    if (_dailyWaterAmount > 100) {
      _dailyWaterAmount -= 100;
      notifyListeners();
      waterCounterPreferences.saveDailyAmount(_dailyWaterAmount);
    }
  }

  void increaseDailyAmount() {
    _dailyWaterAmount += 100;
    notifyListeners();
    waterCounterPreferences.saveDailyAmount(_dailyWaterAmount);
  }

  void drinkingWater() {
    _drunkWaterAmount += _glassCapacity;
    waterCounterPreferences.saveDrunkAmount(_drunkWaterAmount);
    notifyListeners();
  }

  void getWaterData() async {
    _dailyWaterAmount = await waterCounterPreferences.loadDailyAmount();
    _drunkWaterAmount = await waterCounterPreferences.loadDrunkAmount();
    _glassCapacity = await waterCounterPreferences.loadGlassCapacity();
    notifyListeners();
  }
}
