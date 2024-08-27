import 'dart:math';

class GameLogic {
  final int size = 4;
  late List<List<int>> board;
  int score = 0;
  int highScore = 0;

  GameLogic() {
    initGame();
  }

  void initGame() {
    board = List.generate(size, (index) => List.filled(size, 0));
    score = 0;
    randomGenerate();
    randomGenerate();
  }

  void randomGenerate() {
    List<Map<String, int>> emptyPositions = [];
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (board[i][j] == 0) {
          emptyPositions.add({'x': i, 'y': j});
        }
      }
    }
    if (emptyPositions.isNotEmpty) {
      Map<String, int> randomCell =
          emptyPositions[Random().nextInt(emptyPositions.length)];
      board[randomCell['x']!][randomCell['y']!] =
          Random().nextDouble() < 0.9 ? 2 : 4;
    }
  }

  List<int> transform(List<int> line, bool moveDirection) {
    List<int> newLine = line.where((cell) => cell != 0).toList();
    if (!moveDirection) newLine = newLine.reversed.toList();

    for (int i = 0; i < newLine.length - 1; i++) {
      if (newLine[i] == newLine[i + 1]) {
        newLine[i] *= 2;
        score += newLine[i];
        newLine.removeAt(i + 1);
      }
    }

    while (newLine.length < size) {
      newLine.add(0);
    }
    if (!moveDirection) newLine = newLine.reversed.toList();
    return newLine;
  }

  // List<int> transform(List<int> line, bool moveDirection) {
  //   List<int> newLine = line.where((cell) => cell != 0).toList();
  //   if (!moveDirection) newLine = newLine.reversed.toList();

  //   for (int i = 0; i < newLine.length - 1; i++) {
  //     if (newLine[i] == newLine[i + 1]) {
  //       newLine[i] *= 2;
  //       score += newLine[i];
  //       newLine.removeAt(i + 1);
  //     }
  //   }

  //   while (newLine.length < size) {
  //     newLine.add(0);
  //   }
  //   if (!moveDirection) newLine = newLine.reversed.toList();
  //   return newLine;
  // }

  bool move(String direction) {
    bool isChanged = false;
    if (direction == 'ArrowUp' || direction == 'ArrowDown') {
      for (int j = 0; j < size; j++) {
        List<int> column = List.generate(size, (i) => board[i][j]);
        List<int> newColumn = transform(column, direction == 'ArrowUp');
        for (int i = 0; i < size; i++) {
          if (board[i][j] != newColumn[i]) {
            isChanged = true;
            board[i][j] = newColumn[i];
          }
        }
      }
    } else if (direction == 'ArrowLeft' || direction == 'ArrowRight') {
      for (int i = 0; i < size; i++) {
        List<int> row = board[i];
        List<int> newRow = transform(row, direction == 'ArrowLeft');
        if (!isEqual(row, newRow)) {
          isChanged = true;
          board[i] = newRow;
        }
      }
    }
    if (isChanged) {
      randomGenerate();
    }
    return isChanged;
  }

  // bool move(String direction) {
  //   bool isChanged = false;
  //   if (direction == 'ArrowUp' || direction == 'ArrowDown') {
  //     for (int j = 0; j < size; j++) {
  //       List<int> column = List.generate(size, (i) => board[i][j]);
  //       List<int> newColumn = transform(column, direction == 'ArrowUp');
  //       for (int i = 0; i < size; i++) {
  //         if (board[i][j] != newColumn[i]) {
  //           isChanged = true;
  //           board[i][j] = newColumn[i];
  //         }
  //       }
  //     }
  //   } else if (direction == 'ArrowLeft' || direction == 'ArrowRight') {
  //     for (int i = 0; i < size; i++) {
  //       List<int> row = board[i];
  //       List<int> newRow = transform(row, direction == 'ArrowLeft');
  //       if (!isEqual(row, newRow)) {
  //         isChanged = true;
  //         board[i] = newRow;
  //       }
  //     }
  //   }
  //   if (isChanged) {
  //     randomGenerate();
  //   }
  //   return isChanged;
  // }

  bool isEqual(List<int> oldRow, List<int> newRow) {
    for (int i = 0; i < oldRow.length; i++) {
      if (oldRow[i] != newRow[i]) return false;
    }
    return true;
  }

  bool isGameOver() {
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (board[i][j] == 0) return false;
        if (j < size - 1 && board[i][j] == board[i][j + 1]) return false;
        if (i < size - 1 && board[i][j] == board[i + 1][j]) return false;
      }
    }
    return true;
  }
}
