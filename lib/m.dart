import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';

class _DemoAppState extends State<DemoApp> {
  double _pointerValue = 45;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: Container(
        child: SfLinearGauge(
        ranges: [
          LinearGaugeRange(
            startValue: 0,
            endValue: 50,
          ),
        ],
        markerPointers: [
          LinearShapePointer(
            value: 50,
          ),
        ],
        barPointers: [LinearBarPointer(value: 80)],
      ),
      ))),
    );
  }
}
