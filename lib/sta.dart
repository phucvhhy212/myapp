import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const ScrollingList(),
    );
  }
}

class ScrollingList extends StatefulWidget {
  const ScrollingList({Key? key}) : super(key: key);

  @override
  _ScrollingListState createState() => _ScrollingListState();
}

class _ScrollingListState extends State<ScrollingList> {
  final controller = FixedExtentScrollController(initialItem: 1);

  final children = [
    for (int i = 0; i < 6; i++) ScrollingListItem(enabled: i != 0)
  ];

  void scrollListener() {
    if (controller.selectedItem == 1) {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        controller.jumpToItem(1);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(scrollListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("List"),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              RotatedBox(
                quarterTurns: 1,
                child: SizedBox(
                  height: 600,
                  width: 800,
                  child: ListWheelScrollView(
                    controller: controller,
                    itemExtent: 100,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (idx) {
                      if (!children[idx].enabled) {
                        controller.animateToItem(
                          idx + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                      }
                    },
                    children: children,
                  ),
                ),
              ),
              const Positioned(top: 440, child: Icon(Icons.arrow_circle_up))
            ],
          ),
        ));
  }
}

class ScrollingListItem extends StatelessWidget {
  final bool enabled;

  const ScrollingListItem({super.key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: enabled ? Colors.green[200] : Colors.red[200],
      height: 70,
      width: 70,
      alignment: Alignment.center,
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(
          enabled ? "Enabled" : "Disabled",
        ),
      ),
    );
  }
}