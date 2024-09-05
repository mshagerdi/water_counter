import 'dart:async';

import 'package:flutter/material.dart';
import 'package:water_counter/main.dart';
import 'package:water_counter/models/water_counter_data.dart';

class TestTab extends StatelessWidget {
  const TestTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<WaterCounterData> listData = objectBox.getWeeklyWaterCounterList();

    // StreamController<int> _counterController = StreamController<int>();

    // return StreamBuilder(
    //   stream: objectBox.getWaterCounterStream(),
    //   builder: (context, snapshot) => ListTile(
    //     title: Text(_counterController.toString()),
    //   ),
    // );

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(listData[index].amount.toString()),
        subtitle: Text(listData[index].dateTime.toString()),
        trailing: Text(index.toString()),
      ),
      itemCount: listData.length,
    );
  }
}
