import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_counter/provider/water_counter_provider.dart';
import 'package:water_counter/widgets/rounded_button.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final waterData = Provider.of<WaterCounterProvider>(context);

    return Container(
      padding: EdgeInsets.all(11),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Intake goal',
                style: TextStyle(fontSize: 19),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(9),
                    child: Roundedbutton(
                      iconData: Icons.remove,
                      function: waterData.decreaseDailyAmount,
                      color: Colors.redAccent,
                      isDeactive: waterData.dailyWaterAmount == 100,
                    ),
                  ),
                  Text(
                    waterData.dailyWaterAmount.toStringAsFixed(0),
                    style: TextStyle(fontSize: 19),
                  ),
                  Roundedbutton(
                    iconData: Icons.add,
                    function: waterData.increaseDailyAmount,
                    color: Colors.greenAccent,
                    isDeactive: false,
                  ),
                ],
              )
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
