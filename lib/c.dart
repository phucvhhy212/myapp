import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List',
      debugShowCheckedModeBanner: false,
      home: const List(),
    );
  }
}

class List extends StatefulWidget {
  const List({Key? key}) : super(key: key);
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  final _scrollController =
      FixedExtentScrollController(initialItem: DateTime.now().day - 1);

  int itemLength =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
  void scrollListener() {
    if (_scrollController.selectedItem > DateTime.now().day - 1) {
        _scrollController.jumpToItem(DateTime.now().day - 1);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
  int selectedIndex = DateTime.now().day - 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 160,
                width: 300,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: ClickableListWheelScrollView(
                    scrollController: _scrollController,
                    itemHeight: 90,
                    itemCount: itemLength,
                    onItemTapCallback: (index) {
                      print('Tapped on index: $index');
                    },
                    child: ListWheelScrollView.useDelegate(
                      controller: _scrollController,
                      itemExtent: 50,
                      physics: const FixedExtentScrollPhysics(),
                      overAndUnderCenterOpacity: 0.5,
                      perspective: 0.002,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                RotatedBox(
                                  quarterTurns: 1,
                                  child: Text(
                                    '${[
                                      "Mon",
                                      "Tue",
                                      "Wed",
                                      "Thu",
                                      "Fri",
                                      "Sat",
                                      "Sun"
                                    ][DateTime(DateTime.now().year, DateTime.now().month, index + 1).weekday - 1]}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: index == selectedIndex
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: AlignmentDirectional.centerEnd,
                                    height: 2,
                                    color: index == selectedIndex
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                                RotatedBox(
                                  quarterTurns: 1,
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: index == selectedIndex
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: itemLength,
                      ),
                    ),
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_drop_up,
                size: 35,
                color: Colors.white,
              ),
              Text(
                'Selected Index: $selectedIndex',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ));
  }
}
