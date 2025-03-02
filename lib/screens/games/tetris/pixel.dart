import 'package:arcade/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pixel extends StatelessWidget {
  var color;
  var child;
  Pixel({super.key, required this.color, this.child});

  @override
  Widget build(BuildContext context) {
    final dimension = Provider.of<Dimension>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: dimension.screenWidth * 0.07,
        height: dimension.screenWidth * 0.07,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(dimension.getWidth(2)),
        ),
        margin: EdgeInsets.all(dimension.getWidth(1)),
        child: child != null ? Center(child: Text('$child')) : Container(),
      );
    });
  }
}
