// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class HeightRuler extends StatefulWidget {
  const HeightRuler({
    super.key,
    this.width,
    this.height,
    required this.selectedHeight,
    required this.childCount,
    required this.activeColor,
    required this.disabledColor,
  });

  final double? width;
  final double? height;
  final double selectedHeight;
  final int childCount;
  final Color activeColor;
  final Color disabledColor;

  @override
  State<HeightRuler> createState() => _HeightRulerState();
}

class _HeightRulerState extends State<HeightRuler> {
  double selectedHeight = 160;
  int selectedIndex = 25; // Default selected index

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemPurple,
      ),
      home: CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
              height: 200,
              child: ListWheelScrollView.useDelegate(
                itemExtent: 20,
                physics: FixedExtentScrollPhysics(),
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedIndex = index;
                    selectedHeight = index + 140; // Starting height
                  });
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          index % 5 == 0 ? '${index + 140}' : '      ',
                          style: TextStyle(
                            fontSize: 20,
                            color: selectedIndex == index ? Colors.white : Colors.grey,
                          ),
                        ),
                        SizedBox(width: 35),
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          width: index % 5 == 0 ? 56 : 24,
                          height: index % 5 == 0 ? 4 : 2,
                          color: selectedIndex == index ? Colors.white : Colors.grey,
                        ),                       
                      ],
                    );
                  },
                  childCount: 100, // Heights from 140 cm to 240 cm
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
