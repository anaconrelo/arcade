import 'dart:async';
import 'dart:math';

import 'package:arcade/screens/games/tetris/pixel.dart';
import 'package:arcade/screens/games/tetris/tetris_control_button.dart';
import 'package:arcade/screens/games/tetris/tetris_main_screen.dart';
import 'package:arcade/screens/games/tetris/tetris_pause_button.dart';
import 'package:arcade/screens/games/tetris/tetris_piece.dart';
import 'package:arcade/screens/games/tetris/tetris_value.dart';
import 'package:arcade/utils/colors.dart';
import 'package:arcade/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<List<Tetromino?>> gameboard = List.generate(
  colLenght!,
  (i) => List.generate(
    rowLenght,
    (j) => null,
  ),
);

class TetrisGameScreen extends StatefulWidget {
  const TetrisGameScreen({super.key});

  @override
  State<TetrisGameScreen> createState() => _TetrisGameScreenState();
}

class _TetrisGameScreenState extends State<TetrisGameScreen> {
  //current tetris piece
  Tetromino? nextType;
  Piece currentPiece = Piece(type: Tetromino.L);
  late BoardHeight boardHeight;
  Timer? _timer;
  late ScrollController _scrollController;
  bool _isScrollable = false;

  bool gameOver = false;

  bool _isPause = false;

  int scores = 0;

  void startGame() {
    createRandomPiece();
    newPiece();
    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  //game loop
  void gameLoop(Duration frameRate) {
    _timer = Timer.periodic(frameRate, (timer) {
      setState(() {
        clearLines();
        // check landing
        checkLanding();

        if (gameOver == true) {
          _timer?.cancel();
          showGameOverDialog();
        }

        // move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  void newPiece() {
    // create a random object to generate random tetromino types
    Random rand = Random();

    // create a random piece with random type
    nextType = Tetromino.values[rand.nextInt(Tetromino.values.length)];
  }

  // gameover dialog
  void showGameOverDialog() {
    final textTheme = Theme.of(context).textTheme;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => PopScope(
              canPop: false,
              child: AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                title: Text(
                  'GameOver',
                  style:
                      textTheme.headlineLarge!.copyWith(color: AppColors.blue2),
                ),
                content: Text(
                  'Your Score: $scores',
                  style: textTheme.bodyLarge!.copyWith(color: AppColors.blue1),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        _timer?.cancel();
                        gameboard = List.generate(
                          colLenght!,
                          (i) => List.generate(
                            rowLenght,
                            (j) => null,
                          ),
                        );
                        _scrollController.dispose();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Tetris()));
                      },
                      child: Text(
                        'Exit',
                        style:
                            textTheme.titleLarge!.copyWith(color: Colors.white),
                      )),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue3),
                    onPressed: () {
                      resetGame();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.play_arrow_rounded, size: 25),
                    label: Text(
                      "Restart",
                      style: textTheme.labelLarge!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  void resetGame() {
    setState(() {
      gameboard = List.generate(
        colLenght!,
        (i) => List.generate(
          rowLenght,
          (j) => null,
        ),
      );
    });

    gameOver = false;
    scores = 0;
    startGame();
  }

  void createRandomPiece() {
    // create a random object to generate random tetromino types
    Random rand = Random();

    // create a random piece with random type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();
  }

  // gameover
  bool isGameOver() {
    // check if a piece is over
    for (int col = 0; col < rowLenght; col++) {
      if (gameboard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    // start game when load
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _isScrollable = _scrollController.hasClients &&
              _scrollController.offset <
                  _scrollController.position.maxScrollExtent;
        });
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check scrollable state after the first build
      if (_scrollController.hasClients) {
        setState(() {
          _isScrollable = _scrollController.offset <
              _scrollController.position.maxScrollExtent;
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showStartDialog();
    });

    //startGame();
  }

  void showStartDialog() {
    final textTheme = Theme.of(context).textTheme;
    //final dimension = Provider.of<Dimension>(context);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => PopScope(
              canPop: false,
              child: AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                title: Text(
                  'Start The Game',
                  style:
                      textTheme.headlineLarge!.copyWith(color: AppColors.blue2),
                ),
                actions: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue3),
                    onPressed: () {
                      Navigator.pop(context);
                      startGame();
                    },
                    icon: Icon(Icons.play_arrow_rounded, size: 25),
                    label: Text(
                      "PLAY",
                      style: textTheme.labelLarge!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  //check for collision
  bool checkCollision(Direction direction) {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      // calculate the row and column
      int row = (currentPiece.position[i] / rowLenght).floor();
      int col = currentPiece.position[i] % rowLenght;

      // adjust the row and col based on the direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check for collisions with boundaries
      if (col < 0 || col >= rowLenght || row >= colLenght!) {
        return true;
      }

      // check for collisions with other landed pieces
      if (row >= 0 && gameboard[row][col] != null) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    // if going down is occupied
    if (checkCollision(Direction.down)) {
      // mark position as occupied on the gameboard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLenght).floor();
        int col = currentPiece.position[i] % rowLenght;
        if (row >= 0 && col >= 0) {
          gameboard[row][col] = currentPiece.type;
        }
      }
      // once landed create  the next piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    _timer?.cancel();
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);

    currentPiece = Piece(type: nextType!);
    currentPiece.initializePiece();
    newPiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  // move left
  void moveLeft() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // move right
  void moveRight() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // move down fast
  void moveDown() {
    _timer?.cancel();
    Duration frameRate = const Duration(milliseconds: 10);
    gameLoop(frameRate);
  }

  // rotate piece
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // clear line
  void clearLines() {
    // loop through each row from bottom to top
    int count = 0;
    for (int row = colLenght! - 1; row >= 0; row--) {
      // initialize a variable
      bool rowIsFull = true;

      for (int col = 0; col < rowLenght; col++) {
        if (gameboard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      // if row is full, clear the row and shift rows down
      if (rowIsFull) {
        count++;
        // move all rows above to below one position
        for (int r = row; r > 0; r--) {
          gameboard[r] = List.from(gameboard[r - 1]);
        }

        gameboard[0] = List.generate(row, (index) => null);

        //do increase scoring here later
      }
    }
    if (count != 0) {
      scores = scores + (30 * count);
    }
  }

  void pauseNplay() {
    if (_isPause) {
      Duration frameRate = const Duration(milliseconds: 400);
      gameLoop(frameRate);
      setState(() {
        _isPause = false;
      });
    } else {
      _timer?.cancel();
      setState(() {
        _isPause = true;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
    gameboard = List.generate(
      colLenght!,
      (i) => List.generate(
        rowLenght,
        (j) => null,
      ),
    );
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dimension = Provider.of<Dimension>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blue7,
        body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
            _timer?.cancel();
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      title: const Text("Exit The Game?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              _timer?.cancel();
                              gameboard = List.generate(
                                colLenght!,
                                (i) => List.generate(
                                  rowLenght,
                                  (j) => null,
                                ),
                              );
                              _scrollController.dispose();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Tetris()));
                            },
                            child: Text(
                              'Exit',
                              style: textTheme.titleLarge,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              Duration frameRate =
                                  const Duration(milliseconds: 400);
                              gameLoop(frameRate);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Keep Playing',
                              style: textTheme.titleLarge,
                            )),
                      ],
                    ));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: dimension.getHeight(70),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: dimension.screenWidth -
                            (dimension.screenWidth * 0.215),
                        height: dimension.screenWidth * 0.215,
                        color: AppColors.blue5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'SCORE:',
                              style: textTheme.headlineSmall!
                                  .copyWith(color: AppColors.blue2),
                            ),
                            Text(
                              '$scores',
                              style: textTheme.headlineSmall!.copyWith(
                                color: AppColors.blue1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: dimension.screenWidth * 0.215,
                      height: dimension.screenWidth * 0.215,
                      child: _isPause
                          ? TetrisPauseButton(
                              label: 'Play',
                              icon: Icons.play_arrow_rounded,
                              onPressed: pauseNplay,
                            )
                          : TetrisPauseButton(
                              label: 'Pause',
                              icon: Icons.pause,
                              onPressed: pauseNplay,
                            ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: LayoutBuilder(builder: (context, constraints) {
                  boardHeight = BoardHeight(height: constraints.maxHeight);
                  double pixelSize =
                      (dimension.screenWidth + (dimension.getWidth(1) * 2)) *
                          0.07;
                  int? ratio;
                  if (_isScrollable) {
                    ratio = 2;
                  } else {
                    ratio = 1;
                  }
                  colLenght =
                      ((boardHeight.height - (dimension.getWidth(7.5) * 2)) ~/
                              pixelSize) -
                          ratio;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.blue7,
                                width: dimension.getWidth(7.5)),
                            borderRadius:
                                BorderRadius.circular(dimension.getWidth(8)),
                            color: AppColors.blue4,
                          ),
                          child: GridView.builder(
                              controller: _scrollController,
                              itemCount: rowLenght * colLenght!,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: rowLenght,
                              ),
                              itemBuilder: (context, index) {
                                int row = (index / rowLenght).floor();
                                int col = index % rowLenght;
                                if (currentPiece.position.contains(index)) {
                                  return Pixel(
                                    color: currentPiece.color,
                                  );
                                } else if (gameboard[row][col] != null) {
                                  final Tetromino? tetrominoType =
                                      gameboard[row][col];
                                  return Pixel(
                                    color: tetrominoColors[tetrominoType],
                                    child: '',
                                  );
                                } else {
                                  return Center(
                                    child: Pixel(
                                      color: const Color.fromARGB(
                                          128, 174, 227, 251),
                                      child: '',
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                AppColors.blue6,
                                AppColors.blue5,
                                AppColors.blue4,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        width: dimension.screenWidth * 0.215,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            dimension.getWidth(4),
                            dimension.getHeight(16),
                            dimension.getWidth(4),
                            dimension.getHeight(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'NEXT',
                                style: textTheme.headlineSmall!.copyWith(
                                  color: AppColors.blue2,
                                ),
                              ),
                              SizedBox(
                                height: dimension.getHeight(20),
                              ),
                              Padding(
                                padding: EdgeInsets.all(dimension.getWidth(8)),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: nextPieceImage(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              // Control buttons
              Container(
                color: AppColors.blue5,
                height: dimension.getHeight(70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Rotate
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: SizedBox.square(
                          dimension: 50,
                          child: TetrisControlButton(
                              onPressed: rotatePiece,
                              child: const Icon(
                                Icons.rotate_right,
                                color: AppColors.blue1,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Move left
                          TetrisControlButton(
                              onPressed: moveLeft,
                              child: const Icon(
                                Icons.arrow_back,
                                color: AppColors.blue1,
                              )),
                          // move down
                          TetrisControlButton(
                              onPressed: moveDown,
                              child: const Icon(
                                Icons.arrow_downward_rounded,
                                color: AppColors.blue1,
                              )),
                          // Move Right
                          TetrisControlButton(
                              onPressed: moveRight,
                              child: const Icon(
                                Icons.arrow_forward,
                                color: AppColors.blue1,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nextPieceImage() {
    if (nextType != null) {
      if (nextType!.name == 'L') {
        return Image.asset('assets/images/tetris/L.png');
      } else if (nextType!.name == 'J') {
        return Image.asset('assets/images/tetris/J.png');
      } else if (nextType!.name == 'I') {
        return Image.asset('assets/images/tetris/I.png');
      } else if (nextType!.name == 'O') {
        return Image.asset('assets/images/tetris/O.png');
      } else if (nextType!.name == 'S') {
        return Image.asset('assets/images/tetris/S.png');
      } else if (nextType!.name == 'Z') {
        return Image.asset('assets/images/tetris/Z.png');
      } else if (nextType!.name == 'T') {
        return Image.asset('assets/images/tetris/T.png');
      }
    } else {
      return const CircularProgressIndicator(
        color: AppColors.blue1,
      );
    }
    return const CircularProgressIndicator(
      color: AppColors.blue1,
    );
  }
}
