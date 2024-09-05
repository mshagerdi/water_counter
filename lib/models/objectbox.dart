import 'package:flutter/material.dart';
import 'package:water_counter/models/water_counter_data.dart';
import 'package:water_counter/models/water_counter_model.dart';
import 'package:water_counter/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  late final Store _store;

  late final Box<WaterCounterModel> _waterCounterBox;

  late Stream<List<WaterCounterModel>> _waterCounterStream;
  bool listenDone = false;

  late DateTime now;
  double _weeklyWaterDrunk = 0.0;

  late double _todayWaterCounterAmount;

  List<WaterCounterData> _waterCounterList = [];
  late List<WaterCounterData> _weeklyWaterCounterList;

  List<WaterCounterData> _monthlyWaterCounterList = [];

  ObjectBox._create(this._store) {
    _waterCounterBox = Box<WaterCounterModel>(_store);
    if (_waterCounterBox.isEmpty()) {
      _putDemoData();
    }
  }

  static Future<ObjectBox> create() async {
    final store = await openStore(
        directory:
            p.join((await getApplicationDocumentsDirectory()).path, "obx-demo"),
        macosApplicationGroup: "objectbox.demo");
    return ObjectBox._create(store);
  }

  void _putDemoData() {
    final waterCounterDemo = WaterCounterModel(0.0);
    _waterCounterBox.put(waterCounterDemo);
  }

  Stream<List<WaterCounterModel>> getWaterCounterData() {
    final builder = _waterCounterBox
        .query()
        .order(WaterCounterModel_.date, flags: Order.descending);
    _waterCounterStream =
        builder.watch(triggerImmediately: true).map((query) => query.find());
    return _waterCounterStream;
  }

  void createWaterCounterList() {
    if (!listenDone)
      _waterCounterStream.listen((listOfWaterCounter) {
        for (WaterCounterModel waterCounter in listOfWaterCounter) {
          _waterCounterList
              .add(WaterCounterData(waterCounter.date, waterCounter.amount));
          listenDone = true;
          // if (DateUtils.isSameDay(_aWeekAgo, waterCounter.date)) {
          //   _eachDayWeeklyWaterAmount += waterCounter.amount;
          // } else {
          //   _weeklyWaterCounterList.add(WaterCounterData(
          //       DateUtils.dateOnly(waterCounter.date),
          //       _eachDayWeeklyWaterAmount));
          //   _aWeekAgo =
          //       DateTime(_aWeekAgo.year, _aWeekAgo.month, _aWeekAgo.day + 1);
          //   _eachDayWeeklyWaterAmount = waterCounter.amount;
          // }
          // if (DateUtils.isSameMonth(_aMonthAgo, waterCounter.date)) {
          //   _eachDayMonthlyWaterAmount += waterCounter.amount;
          // } else {
          //   _monthlyWaterCounterList.add(WaterCounterData(
          //       DateUtils.dateOnly(waterCounter.date),
          //       _eachDayMonthlyWaterAmount));
          //   _aMonthAgo =
          //       DateTime(_aMonthAgo.year, _aMonthAgo.month, _aMonthAgo.day + 1);
          //   _eachDayMonthlyWaterAmount = waterCounter.amount;
          // }
        }
      });
  }

  Stream<List<WaterCounterModel>> getWaterCounterStream() {
    return _waterCounterStream;
  }

  List<WaterCounterData> getWaterCounterList() {
    createWaterCounterList();
    return _waterCounterList;
  }

  List<WaterCounterData> getWeeklyWaterCounterList() {
    // _waterCounterList = [];
    _weeklyWaterCounterList = List.generate(
      7,
      (index) => WaterCounterData(
          DateTime.now().subtract(Duration(days: 7 - index)), 0.0),
    );

    createWaterCounterList();
    _weeklyWaterDrunk = 0;
    for (int i = 0; i < _waterCounterList.length; i++) {
      for (int day = 0; day < 7; day++) {
        if (DateUtils.isSameDay(_waterCounterList[i].dateTime,
            DateTime.now().subtract(Duration(days: 7 - day)))) {
          _weeklyWaterCounterList[day] = WaterCounterData(
              _waterCounterList[i].dateTime,
              (_weeklyWaterCounterList[day].amount ?? 0) +
                  _waterCounterList[i].amount);
          _weeklyWaterDrunk += _waterCounterList[i].amount;
        }
      }
    }
    return _weeklyWaterCounterList;
  }

  double getWeeklyWaterDrunk() {
    return _weeklyWaterDrunk;
  }

  List<WaterCounterData> getMonthlyWaterCounterList() {
    createWaterCounterList();
    return _monthlyWaterCounterList;
  }

  Stream<List<WaterCounterModel>> getTodayWaterCounterData() {
    now = DateTime.now();

    final builder = _waterCounterBox
        .query((WaterCounterModel_.date.greaterOrEqualDate(DateTime(
          now.year,
          now.month,
          now.day,
        ))))
        .order(WaterCounterModel_.date, flags: Order.descending);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  // double getEachDayWaterCounterData() {
  //   final query = _waterCounterBox.query().build();
  //   PropertyQuery propertyQuery = query.property(WaterCounterModel_.date);
  //   propertyQuery.distinct;
  //   return _waterCounterBox
  //       .query(WaterCounterModel_.date.equals(date))
  //       .build()
  //       .property(WaterCounterModel_.amount)
  //       .sum();
  // }

  double getTodayWaterAmount() {
    now = DateTime.now();

    final builder = _waterCounterBox
        .query((WaterCounterModel_.date.greaterOrEqualDate(DateTime(
      now.year,
      now.month,
      now.day,
    ))));
    _todayWaterCounterAmount =
        builder.build().property(WaterCounterModel_.amount).sum();
    return _todayWaterCounterAmount;
  }

  Future<void> addWaterAmount(double amount) {
    return _waterCounterBox.putAsync(WaterCounterModel(amount));
  }

  Future<void> removeWaterAmount(int id) => _waterCounterBox.removeAsync(id);

  double getWaterAmount(int id) => _waterCounterBox.get(id)!.amount;

  void updateWaterAmount(double amount, int id) {
    WaterCounterModel? waterCounterModel = _waterCounterBox.get(id);
    waterCounterModel!.setAmount(amount);
    _waterCounterBox.put(waterCounterModel);
  }
}
