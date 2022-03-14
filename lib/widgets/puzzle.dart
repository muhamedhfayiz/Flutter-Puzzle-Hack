import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/states/app.state.dart';

class Puzzle extends StatefulWidget {
  final double size;
  const Puzzle({Key? key, required this.size}) : super(key: key);
  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      AppState appState = Provider.of<AppState>(context, listen: false);
      appState.generateTiles(size: widget.size);
      appState.setTileSize(widget.size);
      Timer(const Duration(milliseconds: 100), () {
        appState.setTile(appState.tiles.length - 1);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppState appState = Provider.of<AppState>(context, listen: true);
    return Stack(
      children: appState.tiles,
    );
  }
}
