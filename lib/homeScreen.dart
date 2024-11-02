import 'package:flutter/material.dart';
import 'package:sudoku/gameScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  String _difficulty = "easy";
  
    void _startGame() {
    String nickname = _nicknameController.text;
    if (nickname.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameScreen(
            nickname: nickname,
            difficulty: _difficulty,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, insira seu apelido!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sudoku")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(labelText: "Apelido do Jogador"),
            ),
            RadioListTile(
              title: Text("Fácil"),
              value: "easy",
              groupValue: _difficulty,
              onChanged: (value) => setState(() => _difficulty = value!),
            ),
            RadioListTile(
              title: Text("Médio"),
              value: "medium",
              groupValue: _difficulty,
              onChanged: (value) => setState(() => _difficulty = value!),
            ),
            RadioListTile(
              title: Text("Difícil"),
              value: "hard",
              groupValue: _difficulty,
              onChanged: (value) => setState(() => _difficulty = value!),
            ),
            RadioListTile(
              title: Text("Expert"),
              value: "expert",
              groupValue: _difficulty,
              onChanged: (value) => setState(() => _difficulty = value!),
            ),
            ElevatedButton(
              onPressed: _startGame,
              child: Text("Iniciar Jogo"),
            ),
          ],
        ),
      ),
    );
  }
}



