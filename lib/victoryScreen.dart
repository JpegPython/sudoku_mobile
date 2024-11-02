import 'package:flutter/material.dart';
import 'package:sudoku/homeScreen.dart';
import 'package:sudoku/gameScreen.dart';

class VictoryScreen extends StatelessWidget {
  final String nickname;
  final String difficulty;

  VictoryScreen({required this.nickname, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sudoku"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Parabéns, $nickname! Você completou o Sudoku!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //iniciar uma nova partida
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(
                      nickname: nickname,
                      difficulty: difficulty,
                    ),
                  ),
                );
              },
              child: Text("Nova Partida"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                //tela inicial
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: Text("Voltar para a Tela Inicial"),
            ),
          ],
        ),
      ),
    );
  }
}