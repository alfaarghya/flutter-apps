// ToDo: FIX up & down gesture CUZ not working

import 'package:flutter/material.dart';
import './game_logic.dart';
import './database_helper.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late GameLogic _gameLogic;
  // Offset _startVerticalDragOffset = Offset.zero;
  // Offset _startHorizontalDragOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _gameLogic = GameLogic();
    _loadHighScore();
  }

  Future<void> _loadHighScore() async {
    final highScore = await DatabaseHelper.instance.getHighScore();
    setState(() {
      _gameLogic.highScore = highScore ?? 0;
    });
  }

  Future<void> _saveHighScore() async {
    if (_gameLogic.score > _gameLogic.highScore) {
      await DatabaseHelper.instance.updateHighScore(_gameLogic.score);
      setState(() {
        _gameLogic.highScore = _gameLogic.score;
      });
    }
  }

  Color _getColorForValue(int value) {
    return {
          2: Colors.pink.shade200,
          4: Colors.lightBlue.shade200,
          8: Colors.lightGreen.shade200,
          16: Colors.yellow.shade300,
          32: Colors.orange.shade300,
          64: Colors.lightBlue.shade400,
          128: Colors.yellow.shade500,
          256: Colors.teal.shade300,
          512: Colors.pink.shade300,
          1024: Colors.indigo.shade300,
          2048: Colors.red.shade300,
          4096: Colors.grey.shade400,
        }[value] ??
        const Color(0x9F90CAF9);
  }

  void _handleSwipe(String direction) {
    setState(() {
      if (_gameLogic.move(direction)) {
        _saveHighScore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text('2048 Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _saveHighScore();
              setState(() {
                _gameLogic.initGame();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score: ${_gameLogic.score}',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                Text(
                  'High Score: ${_gameLogic.highScore}',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
          ),
          _grid(),
          if (_gameLogic.isGameOver())
            ElevatedButton(
              onPressed: () {
                _saveHighScore();
                setState(() {
                  _gameLogic.initGame();
                });
              },
              child: const Text('Game Over! Restart'),
            ),
          _buildSwipeButtons(),
        ],
      ),
    );
  }

  Widget _grid() {
    return Expanded(
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dy.abs() > 100) {
            if (details.velocity.pixelsPerSecond.dy < 0) {
              _handleSwipe('ArrowUp');
            } else if (details.velocity.pixelsPerSecond.dy > 0) {
              _handleSwipe('ArrowDown');
            }
          }
        },
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx.abs() > 100) {
            if (details.velocity.pixelsPerSecond.dx < 0) {
              _handleSwipe('ArrowLeft');
            } else if (details.velocity.pixelsPerSecond.dx > 0) {
              _handleSwipe('ArrowRight');
            }
          }
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(15.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: 16,
          itemBuilder: (context, index) {
            final x = index ~/ 4;
            final y = index % 4;
            final value = _gameLogic.board[x][y];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: _getColorForValue(value),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  value != 0 ? '$value' : '',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSwipeButtons() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circle background
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue[100],
            ),
          ),
          // Up button
          Positioned(
            top: 20,
            child: _buildArrowButton(Icons.arrow_upward, 'ArrowUp'),
          ),
          // Down button
          Positioned(
            bottom: 20,
            child: _buildArrowButton(Icons.arrow_downward, 'ArrowDown'),
          ),
          // Left button
          Positioned(
            left: 20,
            child: _buildArrowButton(Icons.arrow_back, 'ArrowLeft'),
          ),
          // Right button
          Positioned(
            right: 20,
            child: _buildArrowButton(Icons.arrow_forward, 'ArrowRight'),
          ),
        ],
      ),
    );
  }

  Widget _buildArrowButton(IconData icon, String direction) {
    return FloatingActionButton(
      backgroundColor: Colors.blue[200],
      onPressed: () {
        _handleSwipe(direction);
      },
      child: Icon(icon),
    );
  }
}
