import 'package:arcade/utils/colors.dart';
import 'package:arcade/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArcadeCard extends StatelessWidget {
  final String imageLink;
  final String label;
  final WidgetBuilder game;
  final Color? backgroundColor;
  const ArcadeCard({
    super.key,
    required this.imageLink,
    required this.label,
    required this.game,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dimension = Provider.of<Dimension>(context);
    return Container(
      margin: EdgeInsets.all(
        dimension.getWidth(2.5),
      ),
      color: backgroundColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.poppy,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColors.maroon,
              width: dimension.getWidth(2.5),
            ),
            borderRadius: BorderRadius.circular(
              dimension.getWidth(20),
            ),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: game));
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: dimension.getHeight(7.5),
            horizontal: 0,
          ),
          child: Column(
            children: [
              Image.asset(
                imageLink,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: dimension.getHeight(8),
              ),
              Text(
                label,
                style: textTheme.titleLarge!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
