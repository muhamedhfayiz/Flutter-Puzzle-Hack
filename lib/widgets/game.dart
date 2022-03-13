import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/states/app.state.dart';
import 'package:puzzle/widgets/tile.dart';

class Game extends StatefulWidget {
  final double size;
  const Game({Key? key, required this.size}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<int> _grid = [];
  final List<Tile> _tiles = [];

  @override
  void didChangeDependencies() {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    _grid = appState.generateGrid(length: 3);
    for (int i = 0; i < _grid.length; i++) {
      Tile tile = Tile(
        index: i,
        size: widget.size / 3,
        value: _grid[i],
        top: (i / 3).floor() * (widget.size / 3),
        left: (i % 3) * (widget.size / 3),
      );
      _tiles.add(tile);
    }
    setState(() {});
    Timer(const Duration(milliseconds: 100), () {
      appState.setTile(_grid.length - 1);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _tiles,
    );
  }
}
