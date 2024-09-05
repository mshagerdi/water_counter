import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_counter/main.dart';
import 'package:water_counter/provider/water_counter_provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:water_counter/widgets/rounded_button.dart';

class GaugeWidget extends StatefulWidget {
  const GaugeWidget({super.key});

  @override
  State<GaugeWidget> createState() => _GaugeWidgetState();
}

class _GaugeWidgetState extends State<GaugeWidget> {
  final double radius = 250;

  @override
  Widget build(BuildContext context) {
    final waterData = Provider.of<WaterCounterProvider>(context);
    objectBox.getWaterCounterData();
    double todayWaterAmount() => objectBox.getTodayWaterAmount();
    return Container(
      color: Colors.blueGrey[300],
      padding: EdgeInsets.only(top: 13),
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 49),
              width: radius,
              height: radius,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade200,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: waterData.dailyWaterAmount,
                  startAngle: 145,
                  endAngle: 35,
                  showLabels: true,
                  showFirstLabel: true,
                  showLastLabel: true,
                  showTicks: true,
                  // labelFormat: '{value}ml',
                  radiusFactor: 0.6,
                  axisLineStyle: AxisLineStyle(
                    cornerStyle: CornerStyle.bothFlat,
                    color: Colors.black12,
                    thickness: 13,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: todayWaterAmount(),
                      cornerStyle: CornerStyle.bothFlat,
                      width: 13,
                      sizeUnit: GaugeSizeUnit.logicalPixel,
                      color: Colors.blueAccent,
                    ),
                    // MarkerPointer(
                    //     value: 50,
                    //     enableDragging: true,
                    //     onValueChanged: (_) {},
                    //     markerHeight: 20,
                    //     markerWidth: 20,
                    //     markerType: MarkerType.circle,
                    //     color: Color(0xFFF8BBD0),
                    //     borderWidth: 2,
                    //     borderColor: Colors.white54)
                  ],
                )
              ],
            ),
          ),
          Stack(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 248),
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () async {
                      await objectBox.addWaterAmount(waterData.glassCapacity);
                      waterData.drinkingWater();
                    },
                    child: Column(
                      children: [
                        Icon(Icons.local_drink),
                        Text(waterData.glassCapacity.toStringAsFixed(0)),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    top: radius / 1.1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Roundedbutton(
                        iconData: Icons.remove,
                        function: waterData.decreaseGlassCapacity,
                        color: Colors.redAccent,
                        isDeactive: waterData.glassCapacity == 25,
                      ),
                      SizedBox(
                        width: 44,
                      ),
                      Roundedbutton(
                        iconData: Icons.add,
                        function: waterData.increaseGlassCapacity,
                        color: Colors.greenAccent,
                        isDeactive: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: radius * 1.5,
            child: Center(
              child: Text(
                '${todayWaterAmount().toStringAsFixed(0)} / ${waterData.dailyWaterAmount.toStringAsFixed(0)} ml',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
