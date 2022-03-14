import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/states/app.state.dart';
import 'package:puzzle/widgets/blurry_container.dart';
import 'package:puzzle/widgets/user_win.dart';

@immutable
class Tile extends StatefulWidget {
  Tile({
    Key? key,
    required this.index,
    required this.size,
    required this.value,
    required this.top,
    required this.left,
  }) : super(key: key);

  final double size;
  final int value;
  double top;
  double left;
  int index;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: widget.top,
      left: widget.left,
      child: GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails details) {
          if (details.delta.dy < 0) {
            _slideUp();
          } else if (details.delta.dy > 0) {
            _slideDown();
          }
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          if (details.delta.dx < 0) {
            _slideLeft();
          } else if (details.delta.dx > 0) {
            _slideRight();
          }
        },
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: widget.value == 0
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: cube(),
                ),
        ),
      ),
    );
  }

  Widget cube() {
    return BlurryContainer(
      value: widget.value.toString(),
      height: widget.size,
      width: widget.size,
      borderRadius: BorderRadius.circular(10),
      bgColor: Colors.lightBlueAccent,
    );
  }

  _slideUp() {
    if (_canSlideUp()) {
      widget.top = widget.top - widget.size;
      setState(() {});
    }
  }

  _slideDown() {
    if (_canSlideDown()) {
      widget.top = widget.top + widget.size;
      setState(() {});
    }
  }

  _slideLeft() {
    if (_canSlideLeft()) {
      widget.left = widget.left - widget.size;
      setState(() {});
    }
  }

  _slideRight() {
    if (_canSlideRight()) {
      widget.left = widget.left + widget.size;
      setState(() {});
    }
  }

  bool _canSlideUp() {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    int index = widget.index;
    int upIndex = index - 3;
    if (upIndex >= 0) {
      if (appState.grid[upIndex] == 0) {
        widget.index = upIndex;
        appState.updateGrid(
            sourceIndex: index, targetIndex: upIndex, value: widget.value);
        _checkPuzzleSolved();
        return true;
      }
    }
    return false;
  }

  bool _canSlideDown() {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    int index = widget.index;
    int downIndex = index + appState.level;
    if (downIndex <= appState.level * appState.level) {
      if (appState.grid[downIndex] == 0) {
        widget.index = downIndex;
        appState.updateGrid(
            sourceIndex: index, targetIndex: downIndex, value: widget.value);
        _checkPuzzleSolved();
        return true;
      }
    }
    return false;
  }

  _canSlideLeft() {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    int index = widget.index;
    int leftIndex = index - 1;
    if (index % appState.level != 0) {
      if (appState.grid[leftIndex] == 0) {
        widget.index = leftIndex;
        appState.updateGrid(
            sourceIndex: index, targetIndex: leftIndex, value: widget.value);
        _checkPuzzleSolved();
        return true;
      }
    }
    return false;
  }

  _canSlideRight() {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    int index = widget.index;
    int rightIndex = index + 1;
    if ((index + 1) % appState.level != 0) {
      if (appState.grid[rightIndex] == 0) {
        widget.index = rightIndex;
        appState.updateGrid(
            sourceIndex: index, targetIndex: rightIndex, value: widget.value);
        _checkPuzzleSolved();
        return true;
      }
    }
    return false;
  }

  _checkPuzzleSolved() {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    appState.setMoves();
    List<int> grid = appState.grid;
    bool isWin = true;
    for (int i = 0; i < grid.length; i++) {
      if (grid[i] != i) {
        isWin = false;
        break;
      }
    }
    if (isWin) {
      Status().userWinAlert(context);
    }
  }
}
