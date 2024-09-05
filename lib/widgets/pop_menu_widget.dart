import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_counter/main.dart';
import 'package:water_counter/models/menu_model.dart';
import 'package:water_counter/provider/water_counter_provider.dart';

class PopMenuWidget extends StatefulWidget {
  const PopMenuWidget({super.key, required this.waterCounterId});

  final int waterCounterId;

  @override
  State<PopMenuWidget> createState() => _PopMenuWidgetState();
}

class _PopMenuWidgetState extends State<PopMenuWidget> {
  final inputController = TextEditingController();

  PopupMenuItem<MenuModel> buildItem(MenuModel item) =>
      PopupMenuItem<MenuModel>(
        child: Text(item.text),
        value: item,
      );

  void onSelect(BuildContext context, String selectedItem, int itemId) {
    _showDialog(context, selectedItem, itemId);
  }

  void updateWaterCounter(int id) {
    if (inputController.text.isNotEmpty) {
      objectBox.updateWaterAmount(double.parse(inputController.text), id);
    }
  }

  Future<void> _showDialog(
      BuildContext context, String title, int itemId) async {
    inputController.text = objectBox.getWaterAmount(itemId).toString();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: title == MenuItems.editItem.text
            ? Row(
                children: [
                  Container(
                    width: 99,
                    child: TextField(
                      controller: inputController,
                    ),
                  ),
                  Text('ml.'),
                ],
              )
            : Text('Are you sure?'),
        actions: [
          TextButton(
              onPressed: title == MenuItems.editItem.text
                  ? () {
                      updateWaterCounter(itemId);
                      Navigator.of(context).pop();
                    }
                  : () {
                      objectBox.removeWaterAmount(itemId);
                      Navigator.of(context).pop();
                    },
              child: Text('Submit')),
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<WaterCounterProvider>(context).getWaterData();
    return PopupMenuButton(
      itemBuilder: (context) => [...MenuItems.items.map(buildItem).toList()],
      icon: Icon(Icons.more_horiz),
      onSelected: (item) => onSelect(context, item.text, widget.waterCounterId),
    );
  }
}
