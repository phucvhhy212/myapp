import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemPurple,
      ),
      home: HeightPicker(),
    );
  }
}

class HeightPicker extends StatefulWidget {
  @override
  _HeightRulerState createState() => _HeightRulerState();
}

// class _HeightRulerState extends State<HeightRuler> {
//   double selectedHeight = 160;
//   int selectedIndex = 25; // Default selected index

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       child: Center(
//         child: 
//           Container(
//             color: ,
//             height: widget.height,
//             child: Column(
//               children: [
//                 Container(
//                   color: Colors.yellow,
//                   height: widget.height != null ? widget.height! * 0.1 : null,
//                 ),
//                 Container(
//                   color: Colors.red,
//                   height: widget.height,
//                   child: ListWheelScrollView.useDelegate(
//                     itemExtent: 20,
//                     physics: FixedExtentScrollPhysics(),
//                     onSelectedItemChanged: (int index) {
//                       setState(() {
//                         selectedIndex = index;
//                         selectedHeight = index + 140; // Starting height
//                         // FFAppState().update(() {
//                         //   setState(() => FFAppState().height = selectedHeight);
//                         // });
//                       });
//                     },
//                     childDelegate: ListWheelChildBuilderDelegate(
//                       builder: (context, index) {
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               index % 5 == 0 ? '${index + 140}' : '      ',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: selectedIndex == index
//                                     ? widget.activeColor
//                                     : widget.disabledColor,
//                               ),
//                             ),
//                             SizedBox(width: 35),
//                             Container(
//                               alignment: AlignmentDirectional.centerEnd,
//                               width: index % 5 == 0 ? 56 : 24,
//                               height: index % 5 == 0 ? 4 : 2,
//                               color: selectedIndex == index
//                                   ? widget.activeColor
//                                   : widget.disabledColor,
//                             ),
//                           ],
//                         );
//                       },
//                       childCount:
//                           widget.childCount, // Heights from 140 cm to 240 cm
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//     );
//   }
// }







class _HeightRulerState extends State<HeightPicker> {
  double selectedHeight = 160;
  int selectedIndex = 25; // Default selected index

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            child: ListWheelScrollView.useDelegate(
              controller: FixedExtentScrollController(initialItem: 25 ),
              itemExtent: 20,
              physics: FixedExtentScrollPhysics(),
              onSelectedItemChanged: (int index) {
                setState(() {
                  print(selectedHeight);
                  selectedIndex = index;
                  selectedHeight =
                      index + 160; // Starting height
                });
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        index % 5 == 0
                            ? '${index + 160}'
                            : '      ',
                        style: TextStyle(
                          fontSize: 20,
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 35),
                      Container(
                        alignment: AlignmentDirectional.centerEnd,
                        width: index % 5 == 0 ? 56 : 24,
                        height: index % 5 == 0 ? 4 : 2,
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.grey[600],
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
    );
  }
}