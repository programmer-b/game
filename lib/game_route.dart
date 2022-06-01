import 'package:flutter/material.dart';
import 'package:game/Widgets/ball.dart';
import 'package:game/Widgets/edit_guess.dart';
import 'package:game/Widgets/game_value.dart';
import 'package:game/utils/number_validator.dart';
import 'Constants/dimens.dart';
import 'Widgets/txt.dart';

class GameRoute extends StatefulWidget {
  const GameRoute({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GameRoute> createState() => _GameRouteState();
}

class _GameRouteState extends State<GameRoute> {
  int balls = -1;
  int strikes = 0;
  int keyDigit = 123;
  final _numberController = TextEditingController();
  final numberKey = GlobalKey<FormState>();
  bool gameStarted = false;
  bool firstSubmitted = false;
  bool strikeOut = false;

  String guessedNumber = "";

  @override
  void initState() {
    // Future.delayed(Duration.zero, () {

    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (strikes == 3) {
      Future.delayed(Duration.zero, () {
        showAlertDialog(context);
      });
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [_restartGame()],
        ),
        body: gameStarted
            ? SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: numberKey,
                  child: Column(
                    children: [
                      GameValue(
                        name: 'Key',
                        value: _keyDigit(),
                      ),
                      const SizedBox(height: Dimens.defaultMargin),
                      GameValue(
                        name: 'Guess',
                        value: firstSubmitted ? guessedNumber : '',
                      ),
                      const SizedBox(
                        height: Dimens.defaultPadding,
                      ),
                      GameValue(
                        name: 'Balls',
                        value: firstSubmitted ? balls.toString() : '0',
                        width: 40,
                        fontSize: 18,
                      ),
                      const SizedBox(
                        height: Dimens.defaultPadding,
                      ),
                      Ball(value: balls, color: Colors.blue),
                      const SizedBox(
                        height: Dimens.defaultPadding,
                      ),
                      GameValue(
                        name: 'Strikes',
                        value: strikes.toString(),
                        width: 60,
                        fontSize: 18,
                      ),
                      const SizedBox(
                        height: Dimens.defaultPadding,
                      ),
                      Ball(value: strikes, color: Colors.red),
                      const SizedBox(
                        height: Dimens.defaultPadding * 2.5,
                      ),
                      EditGuess(
                        controller: _numberController,
                      ),
                      const SizedBox(
                        height: Dimens.defaultMargin * 3,
                      ),
                      _submittButton()
                    ],
                  ),
                ),
              ))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Play ball ~~~',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: Dimens.defaultPadding,
                    ),
                    const Text('Press Start'),
                    const SizedBox(
                      height: Dimens.defaultPadding,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            gameStarted = true;
                            keyDigit = NumberValidator.randomDigit();
                          });
                        },
                        child: const Text('Start'))
                  ],
                ),
              ));
  }

  Widget _restartGame() {
    print('Game restart');

    return TextButton(
        onPressed: () {
          setState(() {
            balls = -1;
            strikes = 0;
            //gameStarted = true;
            keyDigit = NumberValidator.randomDigit();
            firstSubmitted = false;
            _numberController.clear();
          });
          setState(() {});
        },
        child: const Text(
          'New game',
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget _submittButton() {
    return ElevatedButton(
        child: const Txt(
          text: 'Submit',
        ),
        onPressed: () {
          if (numberKey.currentState!.validate()) {
            initValues();
            ballCharacters();
            strikeCharacters();
            setState(() {
              guessedNumber = _numberController.text;
              firstSubmitted = true;
            });
          }
        });
  }

  String _keyDigit() {
    if (keyDigit.toString().length == 3) {
      return keyDigit.toString();
    } else if (keyDigit.toString().length == 2) {
      return '0' + keyDigit.toString();
    } else if (keyDigit.toString().length == 1) {
      return '00' + keyDigit.toString();
    } else {
      return '000';
    }
  }

  void initValues() {
    setState(() {
      balls = -1;
      strikes = 0;
    });
  }

  void ballCharacters() {
    var str = _numberController.text;
    var str2 = keyDigit.toString();

    Set<String> uniqueList = {};
    for (int i = 0; i < str.length; i++) {
      if (str2.contains(str[i])) {
        uniqueList.add(str[i]);
        print("val : ${str[i]}");
      }
    }
    setState(() {
      balls = uniqueList.length;
    });
  }

  strikeCharacters() {
    var str = _numberController.text;
    var str2 = keyDigit.toString();
    if (str2.length == 1) {
      if (str[0].toString() == '0') {
        setState(() {
          strikes = strikes + 1;
        });
      }
      if (str[1].toString() == '0') {
        setState(() {
          strikes = strikes + 1;
        });
      }
      if (str[2].toString() == '0') {
        setState(() {
          strikes = strikes + 1;
        });
      }
    }
    if (str2.length == 2) {
      if (str[0].toString() == '0') {
        setState(() {
          strikes = strikes + 1;
        });
      }
      if (str[1].toString() == str2[0]) {
        setState(() {
          strikes = strikes + 1;
        });
      }
      if (str[2].toString() == str2[1]) {
        setState(() {
          strikes = strikes + 1;
        });
      }
    }

    if (str2.length == 3) {
      for (int i = 0; i < str.length; i++) {
        if (str2[i] == str[i]) {
          setState(() {
            strikes = strikes + 1;
          });
        }
      }
    }
    if (strikes == 3) {
      setState(() {
        debugPrint('Strike i');
        strikeOut == true;
      });
    }
  }

 
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        'Strike out ~~~',
        style: TextStyle(fontSize: 24),
      ),
      content: SizedBox(
        height: 100,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: Dimens.defaultPadding,
            ),
            const Text('Press Ok for a new game'),
            const SizedBox(
              height: Dimens.defaultPadding,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    balls = -1;
                    strikes = 0;
                    gameStarted = true;
                    firstSubmitted = false;
                    _numberController.clear();
                    strikeOut = false;
                    keyDigit = NumberValidator.randomDigit();
                  });
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

extension E on String {
  String lastChars(int n) => substring(length - n);
}
