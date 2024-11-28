import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: WeightPicker(),
      ),
    );
  }
}
final textSpan = TextSpan(
      text: '${currentValue.toInt()}\nLevel',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );

class WeightPicker extends StatefulWidget {
  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  final ScrollController _scrollController = ScrollController();
  double _currentWeight = 128;
  final int minWeight = 0;
  final int maxWeight = 400;
  final double itemWidth = 60;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initial position at the selected weight
      _scrollToWeight(_currentWeight);
    });
  }

  void _scrollToWeight(double weight) {
    _scrollController.jumpTo((weight - minWeight) * itemWidth);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final index = (offset / itemWidth).round();
    final weight = minWeight + index;

    if (weight != _currentWeight) {
      setState(() {
        _currentWeight = weight.toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${_currentWeight.round()} ${FFAppState().weightType ? 'kg' : 'lbs'}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification ||
                notification is ScrollEndNotification) {
              _onScroll();
            }
            return true;
          },
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: maxWeight - minWeight + 1,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final weight = minWeight + index;
                final isSelected = _currentWeight.round() == weight;
                return Container(
                  width: itemWidth,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weight % 5 == 0 ? '$weight' : '   ',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey,
                          fontSize: isSelected ? 20 : 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: isSelected ? 30 : 20,
                        width: 2,
                        color: isSelected ? Colors.white : Colors.grey,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
