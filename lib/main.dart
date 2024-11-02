import 'package:flutter/material.dart';
import 'package:sudoku/homeScreen.dart';

void main() {
  runApp(SudokuApp());
}

class SudokuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sudoku",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      
    );
  }
}


