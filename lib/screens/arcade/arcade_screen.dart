import 'package:arcade/screens/game_loading_screen.dart';
import 'package:arcade/utils/dimension.dart';
import 'package:arcade/utils/games_selection.dart';
import 'package:arcade/widgets/arcade_icon.dart';
import 'package:arcade/widgets/balanced_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArcadeScreen extends StatefulWidget {
  const ArcadeScreen({super.key});

  @override
  State<ArcadeScreen> createState() => _ArcadeScreenState();
}

class _ArcadeScreenState extends State<ArcadeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dimension = Provider.of<Dimension>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Anaconrelo\'s Arcade",
            style: textTheme.headlineLarge!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: dimension.getWidth(5), vertical: 0),
          child: BalancedGridView(
            columnCount: 2,
            children: [
              ArcadeCard(
                  imageLink: 'assets/images/af-logo_outline.png',
                  label: 'Tetris',
                  game: (context) =>
                      const GameLoadingScreen(game: GamesSelection.tetris)),
              ArcadeCard(
                  imageLink: 'assets/images/af-logo_outline.png',
                  label: 'Tetris',
                  game: (context) =>
                      const GameLoadingScreen(game: GamesSelection.tetris)),
              ArcadeCard(
                  imageLink: 'assets/images/af-logo_outline.png',
                  label: 'Tetris',
                  game: (context) =>
                      const GameLoadingScreen(game: GamesSelection.flappy)),
            ],
          ),
        ),
      ),
    );
  }
}
