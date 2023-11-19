
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_screen.dart';

class TwoPlayerGame extends StatefulWidget {
  const TwoPlayerGame({super.key});

  @override
  State<TwoPlayerGame> createState() => _TwoPlayerGameState();
}

class _TwoPlayerGameState extends State<TwoPlayerGame> {

  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  final TextEditingController playerOneController = TextEditingController();
  final TextEditingController playerTwoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323D5B),
      body: Form(
        key: _fromKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter Player Name",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: playerOneController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    )
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    )
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    )
                  ),
                  hintText: "Player One Name",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  )
                ),
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "Please Enter Player One Name";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: playerTwoController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    )
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    )
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    )
                  ),
                  hintText: "Player Two Name",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  )
                ),
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "Please Enter Player Two Name";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
              onTap: () {
                if (_fromKey.currentState!.validate()) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> GameScreen(playerOne: playerOneController.text, playerTwo: playerTwoController.text)));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 50),
                child: const Text("Play Game",
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
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 50),
                child: const Text("Back",
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