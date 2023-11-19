
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/home_screen.dart';

class GameScreen extends StatefulWidget {
  final String playerOne;
  final String playerTwo;
  const GameScreen({super.key, required this.playerOne, required this.playerTwo});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _currentPlayer = "X";
    _winner = "";
    _gameOver = false;
  }

  void _resetGame(){
    setState(() {
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _currentPlayer = "X";
    _winner = "";
    _gameOver = false;
    });
  }

  void _makeMove(int row, int col){
    if (_board[row][col] != "" || _gameOver) {
      return;
    }

    setState(() {
      _board[row][col] = _currentPlayer;

      if (_board[row][0] == _currentPlayer && _board[row][1] == _currentPlayer && _board[row][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }else if (_board[0][col] == _currentPlayer && _board[1][col] == _currentPlayer && _board[2][col] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }else if (_board[0][0] == _currentPlayer && _board[1][1] == _currentPlayer && _board[2][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }else if (_board[0][2] == _currentPlayer && _board[1][1] == _currentPlayer && _board[2][0] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }

      _currentPlayer = _currentPlayer == "X" ? "O" : "X";

      if (!_board.any((row) => row.any((cell) => cell == ""))) {
        _gameOver = true;
        _winner = " It's a Tie";
      }

      if(_winner != ""){
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: "Play Again",
          title: _winner == "X" ? "${widget.playerOne} Won!" : _winner =="O" ? "${widget.playerTwo} Won!" : "It's a Tie",
          btnOkOnPress: (){
            _resetGame();
          }
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323D5B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70,),
            SizedBox(height: 120,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Turn: ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),),
                    Text(_currentPlayer == "X"
                    ? "${widget.playerOne} ($_currentPlayer)" : "${widget.playerTwo}($_currentPlayer),",
                    style: TextStyle(
                      color: _currentPlayer == "X" ? const Color(0xFFE25041) : const Color(0xFF1CBD9E),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
              ],
              ),
            ),
            const SizedBox(height: 20,),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (context, index){
                  int row = index ~/3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: ()=> _makeMove(row, col),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E1E3A),borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(_board[row][col],style: TextStyle(
                          fontSize: 120,
                          fontWeight: FontWeight.bold,
                          color: _board[row][col] == "X"
                          ? const Color(0xFFE25041)
                          : const Color(0xFF1CBD9E),
                        ),),
                      ),
                    ),
                  );
                  
              }),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
              onTap: ()=> _resetGame(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 50),
                child: const Text("Reset",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 50),
                child: const Text("Quit",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                ),
              ),
            )
              ],
            )
          ],
        ),
      ),
    ); 
  }
}