import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class BotGameScreen extends StatefulWidget {
  const BotGameScreen({Key? key}) : super(key: key);

  @override
  State<BotGameScreen> createState() => _BotGameScreenState();
}

class _BotGameScreenState extends State<BotGameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;
  late bool _isSinglePlayer;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _currentPlayer = "X";
    _winner = "";
    _gameOver = false;
    _isSinglePlayer = true;

    if (_isSinglePlayer) {
      _makeComputerMove();
    }
  }

  int minimax(List<List<String>> board, String player) {
    if (_checkWinAI(board, 'O')) {
      return player == 'O' ? 1 : -1;
    } else if (_isBoardFull(board)) {
      return 0;
    }

    List<List<int>> moves = [];
    for (var i = 0; i < board.length; i++) {
      for (var j = 0; j < board[i].length; j++) {
        if (board[i][j] == "") {
          moves.add([i, j]);
        }
      }
    }

    int bestScore = (player == 'O') ? -1000 : 1000;
    for (var move in moves) {
      int row = move[0];
      int col = move[1];
      board[row][col] = player;
      if (player == 'O') {
        int score = minimax(board, 'X');
        bestScore = max(score, bestScore);
      } else {
        int score = minimax(board, 'O');
        bestScore = min(score, bestScore);
      }
      board[row][col] = "";
    }
    return bestScore;
  }

  List<int> getBestMove() {
    List<List<int>> emptyCells = [];
    for (var i = 0; i < _board.length; i++) {
      for (var j = 0; j < _board[i].length; j++) {
        if (_board[i][j] == "") {
          emptyCells.add([i, j]);
        }
      }
    }

    int bestScore = -1000;
    List<int> bestMove = [];
    for (var move in emptyCells) {
      int row = move[0];
      int col = move[1];
      _board[row][col] = 'O';
      int score = minimax(_board, 'X');
      _board[row][col] = "";
      if (score > bestScore) {
        bestScore = score;
        bestMove = [row, col];
      }
    }
    return bestMove;
  }

  void _makeComputerMove() {
    if (_isSinglePlayer && _currentPlayer == "O" && !_gameOver) {
      Timer(const Duration(milliseconds: 500), () {
        List<int> bestMove = getBestMove();
        _makeMove(bestMove[0], bestMove[1]);
      });
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ""));
      _currentPlayer = "X";
      _winner = "";
      _gameOver = false;
    });
    if (_isSinglePlayer && _currentPlayer == "O") {
      _makeComputerMove();
    }
  }

  bool _checkWin(int row, int col) {
    return _checkRow(row) || _checkColumn(col) || _checkDiagonals(row, col);
  }

  bool _checkWinAI(List<List<String>> board, String player) {
    for (var i = 0; i < 3; i++) {
      if ((board[i][0] == player && board[i][1] == player && board[i][2] == player) ||
          (board[0][i] == player && board[1][i] == player && board[2][i] == player)) {
        return true;
      }
    }
    if ((board[0][0] == player && board[1][1] == player && board[2][2] == player) ||
        (board[0][2] == player && board[1][1] == player && board[2][0] == player)) {
      return true;
    }
    return false;
  }

  bool _checkRow(int row) {
    return _board[row][0] == _currentPlayer &&
        _board[row][1] == _currentPlayer &&
        _board[row][2] == _currentPlayer;
  }

  bool _checkColumn(int col) {
    return _board[0][col] == _currentPlayer &&
        _board[1][col] == _currentPlayer &&
        _board[2][col] == _currentPlayer;
  }

  bool _checkDiagonals(int row, int col) {
    if (row == col) {
      return _board[0][0] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][2] == _currentPlayer;
    } else if (row + col == 2) {
      return _board[0][2] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][0] == _currentPlayer;
    }
    return false;
  }

  bool _isBoardFull(List<List<String>> board) {
    return !board.any((row) => row.any((cell) => cell == ""));
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] != "" || _gameOver) {
      return;
    }

    setState(() {
      _board[row][col] = _currentPlayer;

      if (_checkWin(row, col)) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_isBoardFull(_board)) {
        _gameOver = true;
        _winner = " It's a Tie";
      }

      if (!_gameOver) {
        _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
        if (_isSinglePlayer && _currentPlayer == 'O') {
          _makeComputerMove();
        }
      }

      if (_gameOver) {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      btnOkText: "Play Again",
      title: _winner == "X" ? "You Won!" : _winner == "O" ? "Bot Won!" : "It's a Tie",
      btnOkOnPress: () {
        _resetGame();
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323D5B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            SizedBox(
              height: 120,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Turn: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        _currentPlayer == "X"
                            ? "You ($_currentPlayer)"
                            : "Bot ($_currentPlayer),",
                        style: TextStyle(
                          color: _currentPlayer == "X"
                              ? const Color(0xFFE25041)
                              : const Color(0xFF1CBD9E),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5F6B84),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => _makeMove(row, col),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E1E3A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _board[row][col],
                          style: TextStyle(
                            fontSize: 120,
                            fontWeight: FontWeight.bold,
                            color: _board[row][col] == "X"
                                ? const Color(0xFFE25041)
                                : const Color(0xFF1CBD9E),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => _resetGame(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 17,
                      horizontal: 50,
                    ),
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 17,
                      horizontal: 50,
                    ),
                    child: const Text(
                      "Quit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
