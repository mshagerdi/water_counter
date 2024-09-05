import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_counter/components/history_tab.dart';
import 'package:water_counter/components/home_tab.dart';
import 'package:water_counter/components/settings_tab.dart';
import 'package:water_counter/components/test_tab.dart';
import 'package:water_counter/constants/constants.dart';
import 'package:water_counter/main.dart';
import 'package:water_counter/models/water_counter_data.dart';
import 'package:water_counter/provider/water_counter_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final waterData = Provider.of<WaterCounterProvider>(context, listen: false);
    waterData.getWaterData();
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(appTitle),
            bottom: TabBar(
              labelColor: Colors.grey[900],
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              unselectedLabelColor: Colors.grey[800],
              unselectedLabelStyle: TextStyle(
                fontSize: 13,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.water_drop),
                      Text('Home'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.history),
                      Text('History'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.settings),
                      Text('Settings'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            HomeTab(),
            // TestTab(),
            HistoryTab(),
            // SettingsTab(),
            SettingsTab(),
          ]),
        ));
  }
}
