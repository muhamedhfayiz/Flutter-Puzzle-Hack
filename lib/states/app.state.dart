import 'package:flutter/material.dart';
import 'package:puzzle/widgets/tile.dart';

class AppState extends ChangeNotifier {
  final List<int> _grid = [];
  List<Tile> _tiles = [];
  int _level = 3;
  int _tile = 0;
  int _moves = 0;
  bool _darkMode = false;
  double _tileSize = 0;
  num _hour = 0;
  num _minute = 0;
  num _second = 0;
  bool _stopTimer = false;

  List<int> get grid => _grid;
  List<Tile> get tiles => _tiles;
  int get level => _level;
  int get tile => _tile;
  int get moves => _moves;
  bool get darkMode => _darkMode;
  double get tileSize => _tileSize;
  num get hour => _hour;
  num get minute => _minute;
  num get second => _second;
  bool get stopTimer => _stopTimer;

  void setTile(int val) {
    _tile = val;
    notifyListeners();
  }

  void setStopTimer(bool val) {
    _stopTimer = val;
    notifyListeners();
  }

  void setTime(num second) {
    if (!stopTimer) {
      _second++;
      if (_second == 60) {
        _second = 0;
        _minute++;
      }
      if (_minute == 60) {
        _minute = 0;
        _hour++;
      }
      notifyListeners();
    }
  }

  void resetTime() {
    _hour = 0;
    _minute = 0;
    _second = 0;
  }

  void setMode(bool val) {
    _darkMode = val;
    notifyListeners();
  }

  void setMoves() {
    _moves++;
    notifyListeners();
  }

  void resetMoves() {
    _moves = 0;
    notifyListeners();
  }

  void setTileSize(double val) {
    _tileSize = val;
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

  void generateTiles({required double size}) {
    resetTime();
    resetMoves();
    List<Tile> tiles = [];
    List<int> grids = generateGrid(length: _level);
    setTile(grids.length - 1);
    for (int i = 0; i < grids.length; i++) {
      Tile tile = Tile(
        index: i,
        size: size / level,
        value: grids[i],
        top: (i / level).floor() * (size / level),
        left: (i % level) * (size / level),
      );
      tiles.add(tile);
    }
    _tiles.clear();
    _tiles = tiles;
    notifyListeners();
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
    resetMoves();
    notifyListeners();
    generateTiles(size: tileSize);
  }
}
