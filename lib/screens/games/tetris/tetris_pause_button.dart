import 'package:arcade/utils/colors.dart';
import 'package:arcade/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TetrisPauseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const TetrisPauseButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dimension = Provider.of<Dimension>(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: AppColors.blue1,
          width: dimension.getWidth(4),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            dimension.getWidth(2),
          ),
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(dimension.getWidth(8)),
        child: Column(
          children: [
            Text(
              label,
              style: textTheme.bodyLarge!.copyWith(
                color: AppColors.blue1,
              ),
            ),
            Icon(
              icon,
              size: dimension.getWidth(30),
              color: AppColors.blue1,
            ),
          ],
        ),
      ),
    );
  }
}
