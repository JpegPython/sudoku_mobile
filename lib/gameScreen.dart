import 'package:flutter/material.dart';
import 'package:sudoku_dart/sudoku_dart.dart';
import 'package:sudoku/victoryScreen.dart';

class GameScreen extends StatefulWidget {
  final String nickname;
  final String difficulty;

  GameScreen({required this.nickname, required this.difficulty});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<int?>> _board = [];
  List<List<int?>> _boardResolved = [];

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }


  void _startNewGame() {
    setState(() {
      Sudoku sudoku= _createSudoku(widget.difficulty);
      _board = _createBoard(sudoku,false);
      _boardResolved = _createBoard(sudoku,true);
    });
  }


  void _setNumber(int row, int col, int number) {
    if (_isNumberValid(row, col, number)) {
      setState(() {
        _board[row][col] = number;
      });
    } else {
      // error feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Número inválido na posição")),
      );
    }
  }


  bool _isNumberValid(int row, int col, int number) {
    for (int i = 0; i < 9; i++) {
      if (_board[row][i] == number || _board[i][col] == number) return false;
    }

    int startRow = (row ~/ 3) * 3;
    int startCol = (col ~/ 3) * 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[startRow + i][startCol + j] == number) return false;
      }
    }
    return true;
  }


  void _checkCompletion() {
    for (var row in _board) {
      if (row.contains(null)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Jogo incompleto, complete-o."))
        );
        return;
      }
    }
    bool isComplete = _board.toString() == _boardResolved.toString();
  
    if (isComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VictoryScreen(
            nickname: widget.nickname,
            difficulty: widget.difficulty,
          ),
        ),
      );
    } 
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Jogo incorreto, tente novamente.")),
      );
    }
  }


  Sudoku _createSudoku(String difficulty) {
    Sudoku sudoku;
    if (difficulty == "easy") {
      sudoku = Sudoku.generate(Level.easy);
    }
    else if (difficulty == "medium") {
      sudoku = Sudoku.generate(Level.medium);
    } 
    else if (difficulty == "hard") {
      sudoku = Sudoku.generate(Level.hard);
    } 
    else if (difficulty == "expert") {
      sudoku = Sudoku.generate(Level.expert);
    }
    else {
      sudoku = Sudoku.generate(Level.easy);
    }
    return (sudoku);
  }


  List<List<int?>> _createBoard(Sudoku sudoku, bool resolved) {

    List<List<int?>> board = [];
    if (resolved) {
      List<int> boardAux = sudoku.solution;
      for (int i = 0; i < 9; i++) {
        board.add(boardAux.sublist(i*9, (i+1)*9).map((e) => e==-1?null:e).toList());
      }
    }
    else {
      List<int> boardAux = sudoku.puzzle;
      for (int i = 0; i < 9; i++) {
        board.add(boardAux.sublist(i*9, (i+1)*9).map((e) => e==-1?null:e).toList());
      }
    }
    return board;
  }
  String _getDifficultyText(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return 'Fácil';
      case 'medium':
        return 'Médio';
      case 'hard':
        return 'Difícil';
      case 'expert':
        return 'Expert';
      default:
        return 'Desconhecida';
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sudoku"),
      ),
      body: Column(
        children: [
          Text("Jogador: ${widget.nickname}"),
          Text("Dificuldade: ${_getDifficultyText(widget.difficulty)}"),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 9,
                childAspectRatio: 1,
              ),
              itemCount: 81,
              itemBuilder: (context, index) {
                int row = index ~/ 9;
                int col = index % 9;
                return GestureDetector(
                  onTap: () async {
                    int? selectedNumber = await _showNumberPicker();
                    if (selectedNumber != null) {
                      _setNumber(row, col, selectedNumber);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: _board[row][col] == null ? Colors.white : Colors.grey[200],
                    ),
                    child: Center(
                      child: Text(
                        _board[row][col]?.toString() ?? "",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _startNewGame,
            child: Text("Novo Jogo"),
          ),
          ElevatedButton(
            onPressed: _checkCompletion, 
            child: Text("Finalizar jogo")
          ),
          // Botao de hack para resolver o jogo
          /*
          ElevatedButton(
            onPressed: () => setState(() => _board = _boardResolved), 
            child: Text("Resolver jogo")
          )
          */
        ],
      ),
    );
  }

  Future<int?> _showNumberPicker() {
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Escolha um número"),
          content: Wrap(
            children: List.generate(9, (index) {
              return GestureDetector(
                onTap: () => Navigator.pop(context, index + 1),
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(4),
                  child: Text((index + 1).toString()),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}