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
                        color: Color(AppColors.darkBlue),
                      ),
                      Text(
                        ' ${appState.moves} moves',
                        style:
                            const TextStyle(color: Color(AppColors.darkBlue)),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      ' | ',
                      style: TextStyle(
                        color: Color(AppColors.darkBlue),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.timer,
                        color: Color(AppColors.darkBlue),
                      ),
                      Text(
                        ' ${appState.hour}:${appState.minute}:${appState.second}',
                        style: const TextStyle(
                          color: Color(AppColors.darkBlue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                child: const Text('New game'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(150, 50),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(color: Colors.white, fontSize: 20),
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
            ),
          ],
        );
      },
    );
  }
}
