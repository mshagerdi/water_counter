import 'package:flutter/material.dart';

class Roundedbutton extends StatelessWidget {
  Roundedbutton({
    required this.iconData,
    required this.function,
    required this.color,
    required this.isDeactive,
  });

  final IconData iconData;
  final VoidCallback function;
  final Color color;
  final bool isDeactive;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDeactive ? null : function,
      child: Icon(iconData),
      style: ButtonStyle(
        shape: WidgetStateProperty.all(CircleBorder()),
        padding: WidgetStateProperty.all(EdgeInsets.all(9)),
        backgroundColor:
            WidgetStateProperty.all(isDeactive ? Colors.grey : color),
        // <-- Button color
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(WidgetState.pressed))
              return Colors.blueGrey; // <-- Splash color
          },
        ),
      ),
    );
  }
}
