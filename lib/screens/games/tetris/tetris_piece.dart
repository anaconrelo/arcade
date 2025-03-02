import 'dart:ui';

import 'package:arcade/screens/games/tetris/tetris_game_screen.dart';
import 'package:arcade/screens/games/tetris/tetris_value.dart';
import 'package:flutter/material.dart';

class Piece {
  //types of tetris piece
  Tetromino type;

  Piece({required this.type});

  List<int> position = [];

  Color get color {
    return tetrominoColors[type] ?? Colors.white;
  }

  //generate the integers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  //move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLenght;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  // rotate piece
  int rotationState = 1;
  void rotatePiece() {
    // new position

    List<int> newPosition = [];

    // rotate the piece based on it's type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + rowLenght,
              position[1] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenght - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLenght,
              position[1],
              position[1] - rowLenght,
              position[1] - rowLenght - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowLenght + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + rowLenght,
              position[1] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLenght - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLenght,
              position[1],
              position[1] - rowLenght,
              position[1] - rowLenght + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLenght - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + rowLenght,
              position[1] + 2 * rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + rowLenght,
              position[1],
              position[1] - rowLenght,
              position[1] - 2 * rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetromino.O:
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLenght - 1,
              position[1] + rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLenght,
              position[0],
              position[0] + 1,
              position[0] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] - rowLenght - 1,
              position[1] - rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowLenght,
              position[0],
              position[0] + 1,
              position[0] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[0] + rowLenght - 2,
              position[1],
              position[2] + rowLenght - 1,
              position[3] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLenght + 2,
              position[1],
              position[2] - rowLenght + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[0] + rowLenght - 2,
              position[1],
              position[2] + rowLenght - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowLenght + 2,
              position[1],
              position[2] - rowLenght + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[2] - rowLenght,
              position[2],
              position[2] + 1,
              position[2] + rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] - rowLenght,
              position[1] - 1,
              position[1],
              position[1] + rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[2] - rowLenght,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      default:
    }
  }

  // check if valid position
  bool positionIsValid(int position) {
    // get the row and col of position
    int row = (position / rowLenght).floor();
    int col = position % rowLenght;

    // if the position is taken, return false
    if (row < 0 || col < 0 || gameboard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  // check if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      // return false if any position is taken
      if (!positionIsValid(pos)) {
        return false;
      }

      // get the col of position
      int col = pos % rowLenght;

      // check if the first  or last column is occupied
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLenght - 1) {
        lastColOccupied = true;
      }
    }

    // if there is a piece in the first col and alst col, it is going through the wall
    return !(firstColOccupied && lastColOccupied);
  }
}
