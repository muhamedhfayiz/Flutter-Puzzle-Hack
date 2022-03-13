import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/states/app.state.dart';
import 'package:puzzle/widgets/blurry_container.dart';

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
  final double top;
  final double left;
  int index;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  double _size = 0;
  int _value = 0;
  double _top = 0;
  double _left = 0;
  int _index = 0;

  @override
  void initState() {
    _size = widget.size;
    _value = widget.value;
    _top = widget.top;
    _left = widget.left;
    _index = widget.index;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: _top,
      left: _left,
      child: GestureDetector(
        onVerticalDragEnd: (DragEndDetails details) {
          if (details.velocity.pixelsPerSecond.dy < -250) {
            _slideUp();
          } else if (details.velocity.pixelsPerSecond.dy > 250) {
            _slideDown();
          }
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.velocity.pixelsPerSecond.dx < -250) {
            _slideLeft();
          } else if (details.velocity.pixelsPerSecond.dx > 250) {
            _slideRight();
          }
        },
        child: SizedBox(
          width: _size,
          height: _size,
          child: _value == 0
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
      value: _value.toString(),
      height: _size,
      width: _size,
      borderRadius: BorderRadius.circular(10),
      bgColor: Colors.lightBlueAccent,
    );
  }

  _slideUp() {
    if (_canSlideUp()) {
      _top = _top - _size;
      setState(() {});
    }
  }

  _slideDown() {
    if (_canSlideDown()) {
      _top = _top + _size;
      setState(() {});
    }
  }

  _slideLeft() {
    if (_canSlideLeft()) {
      _left = _left - _size;
      setState(() {});
    }
  }

  _slideRight() {
    if (_canSlideRight()) {
      _left = _left + _size;
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
            sourceIndex: index, targetIndex: upIndex, value: _value);
        return true;
      }
    }
    return false;
  }

  bool _canSlideDown() {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    int index = widget.index;
    int downIndex = index + 3;
    if (downIndex <= 3 * 3) {
      if (appState.grid[downIndex] == 0) {
        widget.index = downIndex;
        appState.updateGrid(
            sourceIndex: index, targetIndex: downIndex, value: _value);
        return true;
      }
    }
    return false;
  }

  _canSlideLeft() {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    int index = widget.index;
    int leftIndex = index - 1;
    if (index % 3 != 0) {
      if (appState.grid[leftIndex] == 0) {
        widget.index = leftIndex;
        appState.updateGrid(
            sourceIndex: index, targetIndex: leftIndex, value: _value);
        return true;
      }
    }
    return false;
  }

  _canSlideRight() {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    int index = widget.index;
    int rightIndex = index + 1;
    if ((index + 1) % 3 != 0) {
      if (appState.grid[rightIndex] == 0) {
        widget.index = rightIndex;
        appState.updateGrid(
            sourceIndex: index, targetIndex: rightIndex, value: _value);
        return true;
      }
    }
    return false;
  }
}
