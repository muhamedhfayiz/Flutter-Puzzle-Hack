import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  final List<int> _grid = [];
  int _level = 3;
  int _tile = 0;
  int _moves = 0;

  List<int> get grid => _grid;
  int get level => _level;
  int get tile => _tile;
  int get moves => _moves;

  void setTile(int val) {
    _tile = val;
    notifyListeners();
  }

  void setMoves(int val) {
    _moves = val;
    notifyListeners();
  }

  List<int> generateGrid({required int length}) {
    _grid.clear();
    int count = length * length;
    for (int i = 0; i < count; i++) {
      _grid.add(i);
    }
    _grid.shuffle();

    return _grid;
  }

  void updateGrid({
    required int sourceIndex,
    required int targetIndex,
    required int value,
  }) {
    _grid[targetIndex] = value;
    _grid[sourceIndex] = 0;
  }

  void updateLevel(int val) {
    _level = val;
    notifyListeners();
  }
}
