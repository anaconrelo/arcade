import 'package:arcade/screens/arcade/arcade_screen.dart';
import 'package:arcade/screens/games/tetris/tetris_main_screen.dart';
import 'package:arcade/utils/colors.dart';
import 'package:arcade/utils/dynamic_theme.dart';
import 'package:arcade/utils/games_selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameLoadingScreen extends StatefulWidget {
  final GamesSelection game;
  const GameLoadingScreen({super.key, required this.game});

  @override
  State<GameLoadingScreen> createState() => _GameLoadingScreenState();
}

class _GameLoadingScreenState extends State<GameLoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        _goToGame(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(
      () {
        debugPrint('Setting dynamic theme');
        context.read<DynamicTheming>().setNewTheme(
              const DynamicThemingData(
                primaryColor: AppColors.blue5,
                secondaryColor: AppColors.blue1,
              ),
            );
      },
    );
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

  void _goToGame(BuildContext context) {
    switch (widget.game) {
      case GamesSelection.tetris:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Tetris()));
      case GamesSelection.flappy:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ArcadeScreen()));
    }
  }
}
