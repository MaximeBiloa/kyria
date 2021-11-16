import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class WindowsButtons extends StatefulWidget {
  WindowsButtons({required this.themeMode});
  bool themeMode;

  @override
  _WindowsButtonsState createState() => _WindowsButtonsState();
}

class _WindowsButtonsState extends State<WindowsButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          MinimizeWindowButton(
              colors: WindowButtonColors(iconNormal: Colors.grey.shade500)),
          MaximizeWindowButton(
              colors: WindowButtonColors(iconNormal: Colors.grey.shade500)),
          CloseWindowButton(
            colors: WindowButtonColors(
                iconNormal: Colors.grey.shade500, mouseOver: Colors.red),
          )
        ],
      ),
    );
  }
}
