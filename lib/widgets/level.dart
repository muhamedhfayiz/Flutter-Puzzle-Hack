import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/consts/colors.dart';
import 'package:puzzle/models/action_chip_model.dart';
import 'package:puzzle/states/app.state.dart';

class Level extends StatefulWidget {
  const Level({Key? key}) : super(key: key);

  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  final List<ActionChipModel> _actions = [
    ActionChipModel(0, 'Easy', true),
    ActionChipModel(1, 'Medium', false),
    ActionChipModel(2, 'Hard', false),
  ];
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 300,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Center(child: _actionChip(_actions[0])),
            const SizedBox(width: 15),
            Center(child: _actionChip(_actions[1])),
            const SizedBox(width: 15),
            Center(child: _actionChip(_actions[2])),
          ],
        ),
      ),
    );
  }

  Widget _actionChip(ActionChipModel action) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: action.isActive ? 1.1 : 1.0,
      child: ActionChip(
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            action.text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: action.isActive
            ? const Color(AppColors.darkBlue)
            : const Color(AppColors.lightBlue),
        onPressed: () {
          _updateAction(action.id);
        },
      ),
    );
  }

  _updateAction(int id) {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    for (ActionChipModel action in _actions) {
      if (id == action.id) {
        action.isActive = true;
      } else {
        action.isActive = false;
      }
    }

    switch (id) {
      case 0:
        appState.updateLevel(3);
        break;
      case 1:
        appState.updateLevel(4);
        break;
      case 2:
        appState.updateLevel(5);
        break;
      default:
    }
    setState(() {});
  }
}
