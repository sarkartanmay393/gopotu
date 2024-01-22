import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Order_Tracking extends StatelessWidget {
final bool isFirst;
final bool isLast;
const Order_Tracking({
  required this.isFirst,
  required this.isLast
});
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle:LineStyle(color: Colors.green),
      indicatorStyle: IndicatorStyle(
        width: 20
      ),
    );
  }
}
