import 'package:arcade/screens/games/tetris/tetris_game_screen.dart';
import 'package:arcade/screens/startscreen.dart';
import 'package:arcade/utils/colors.dart';
import 'package:arcade/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tetris extends StatefulWidget {
  const Tetris({super.key});

  @override
  State<Tetris> createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dimension = Provider.of<Dimension>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColors.blue5,
              AppColors.blue1,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(dimension.getWidth(24)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "TETRIS LOGO",
                    style: textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: dimension.getHeight(68),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TetrisGameScreen()));
                    },
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      size: dimension.getWidth(75),
                    ),
                    label: Text(
                      "PLAY",
                      style: textTheme.displayMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: dimension.getHeight(50),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const StartScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.pennRed,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: dimension.getHeight(15),
                            ),
                            child: Icon(
                              Icons.exit_to_app_rounded,
                              size: dimension.getHeight(75),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: dimension.getHeight(25),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: dimension.getHeight(15),
                            ),
                            child: Icon(
                              Icons.settings,
                              size: dimension.getHeight(75),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
