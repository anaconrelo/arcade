import 'package:arcade/utils/colors.dart';
import 'package:arcade/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TetrisControlButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const TetrisControlButton(
      {super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final dimension = Provider.of<Dimension>(context);
    return SizedBox.square(
      dimension: 50,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: AppColors.blue1,
            width: dimension.getWidth(2),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              dimension.getWidth(2),
            ),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        label: child,
      ),
    );
  }
}
