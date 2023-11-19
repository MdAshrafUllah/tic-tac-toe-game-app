
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/two_player_game.dart';

import 'game_screen_with_bot.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323D5B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> BotGameScreen()));
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent, width: 2),
                ),
                child: Center(child: Text("Single",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
              ),
            ),
            SizedBox(height: 24,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TwoPlayerGame()));
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber, width: 2),
                ),
                child: Center(child: Text("Two Player",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
              ),
            )
          ],
        ),
      ),
    );
  }
}