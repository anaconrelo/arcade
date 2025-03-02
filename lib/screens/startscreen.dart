import 'package:arcade/screens/arcade/arcade_screen.dart';
import 'package:arcade/utils/colors.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        _goToMainScreen(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.poppy,
          body: Stack(
            children: [
              Container(
                color: Colors.black38,
                height: double.infinity,
                alignment: Alignment.center,
                child: const FadeInImage(
                  fadeInDuration: Duration(milliseconds: 300),
                  fadeOutDuration: Duration(milliseconds: 300),
                  placeholder: AssetImage('assets/images/af-logo_outline.png'),
                  image: AssetImage('assets/images/af-logo_outline.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToMainScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const ArcadeScreen()));
  }
}
