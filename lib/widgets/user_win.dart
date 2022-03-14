import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/consts/colors.dart';
import 'package:puzzle/states/app.state.dart';

class Status {
  Future<void> userWinAlert(BuildContext context) async {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            'Congratulations',
            style: TextStyle(color: Color(AppColors.darkBlue)),
          )),
          actionsAlignment: MainAxisAlignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset('assets/images/dash.png'),
              ),
              const SizedBox(height: 20),
              const Text('You solved the puzzle',
                  style: TextStyle(
                      color: Color(AppColors.darkBlue), fontSize: 20)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.hand_draw,
                        color: Color(AppColors.lightBlue),
                      ),
                      Text(
                        '${appState.moves} Moves',
                        style:
                            const TextStyle(color: Color(AppColors.lightBlue)),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('|',
                        style: TextStyle(color: Color(AppColors.lightBlue))),
                  ),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.timer,
                        color: Color(AppColors.lightBlue),
                      ),
                      Text(
                          '${appState.hour}:${appState.minute}:${appState.second}',
                          style: const TextStyle(
                              color: Color(AppColors.lightBlue))),
                    ],
                  )
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'START NEW GAME',
                style: TextStyle(color: Color(AppColors.darkBlue)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
