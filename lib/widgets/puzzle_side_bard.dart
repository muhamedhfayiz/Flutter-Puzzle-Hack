import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/consts/colors.dart';
import 'package:puzzle/states/app.state.dart';

class PuzzleSideBar extends StatelessWidget {
  const PuzzleSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppState appState = Provider.of<AppState>(context, listen: true);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Puzzle Challenge',
            style: TextStyle(
                color: appState.darkMode
                    ? Colors.white
                    : const Color(AppColors.darkBlue),
                fontSize: 50,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${appState.moves} Moves | ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: appState.darkMode
                    ? Colors.white
                    : const Color(AppColors.darkBlue),
              ),
            ),
            Text(
              '${appState.tile} Tiles',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: appState.darkMode
                    ? Colors.white
                    : const Color(AppColors.darkBlue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => appState.generateTiles(size: appState.tileSize),
          child: const Text('New game'),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
              const Size(150, 50),
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(color: Colors.white, fontSize: 22),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(AppColors.darkBlue),
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
