import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_counter/main.dart';
import 'package:water_counter/models/water_counter_model.dart';
import 'package:water_counter/provider/water_counter_provider.dart';
import 'package:water_counter/widgets/gauge_widget.dart';
import 'package:water_counter/widgets/pop_menu_widget.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<WaterCounterProvider>(context).getWaterData();

    return Column(
      children: [
        GaugeWidget(),
        Expanded(
          child: StreamBuilder(
            stream: objectBox.getTodayWaterCounterData(),
            builder: (context, snapshot) => ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.hasData ? snapshot.data!.length : 0,
              itemBuilder: _itemBuilder(snapshot.data ?? []),
            ),
          ),
        ),
      ],
    );
  }
}

Card Function(BuildContext, int) _itemBuilder(
        List<WaterCounterModel> waterCounterList) =>
    (BuildContext context, int index) => waterCounterList[index].amount > 0
        ? Card(
            child: ListTile(
              leading: Icon(Icons.local_drink),
              title: Text(
                '${waterCounterList[index].amount.toStringAsFixed(0)} ml',
              ),
              subtitle: Text(waterCounterList[index].date.toString()),
              trailing: PopMenuWidget(
                waterCounterId: waterCounterList[index].id,
              ),
            ),
          )
        : Card(
            child: null,
          );
