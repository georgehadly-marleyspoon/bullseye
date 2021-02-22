import 'dart:ui';

import 'package:Bullseye/score.dart';
import 'package:Bullseye/styledbutton.dart';
import 'package:Bullseye/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:Bullseye/prompt.dart';
import 'control.dart';
import 'package:Bullseye/models/gamemodel.dart';
import 'dart:math';
import 'package:Bullseye/hitmebutton.dart';

void main() => runApp(BullsEyeApp());

class BullsEyeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US')
      ],
      title: "BullsEye",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GamePage(title: 'BullsEye Main page'),
    );
  }
}

class GamePage extends StatefulWidget {
  GamePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool _alertIsVisiable = false;
  GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(_newTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 32.0),
                child: Prompt(targetValue: _model.target),
              ),
              Control(model: _model),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: HiteMeButton(
                    onPressed: () {
                      _showAlert(context);
                      this._alertIsVisiable = true;
                      _bonus();
                    },
                    text: AppLocalizations.of(context).hitme
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Score(totalScore: _model.totalScore, round: _model.round, onStartOver: _startNewGame),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _sliderValue() => _model.current;

  void _totalScore() => _model.totalScore += _pointsForCurrentRound();

  int _pointsForCurrentRound() => 100 - _amountOff() + _bonus();

  int _amountOff() => (_model.target - _sliderValue()).abs();

  int _newTargetValue() => Random().nextInt(100) + 1;

  void _startNewGame() {
    setState(() {
      _model.round = GameModel.ROUND_START;
      _model.totalScore = GameModel.SCORE_START;
      _model.target = _newTargetValue();
      _model.current = GameModel.SLIDER_START;
    });
  }

  void _showAlert(BuildContext context) {
    Widget okButton = StyledButton(
      onPressed: () {
        Navigator.of(context).pop();
        this._alertIsVisiable = true;
        setState(() {
          _totalScore();
          _model.target = _newTargetValue();
          _model.round +=1;
        });
      },
      icon: Icons.close,
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                _alertTitle(),
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("The slider's value is",
                    textAlign: TextAlign.center
                ),
                Text("${_sliderValue()}",
                  style: TargetTextStyle.headline4(context),
                  textAlign: TextAlign.center
                ),
                Text("\n you scored ${_pointsForCurrentRound()} points this round. ",
                    textAlign: TextAlign.center
                ),
              ],
            ),
            actions: [
              okButton
            ],
          );
        }
    );
  }

  int _bonus() {
    var difference = _amountOff();
    var bonus = 0;
    switch(difference) {
      case 0:
        bonus = 100;
        break;

        case 1:
          bonus = 50;
          break;
    }
    return bonus;
  }

  String _alertTitle() {
    var difference = _amountOff();

    String title;
    if  (difference == 0) {
      title = "Perfect!";
    } else if (difference < 5) {
      title = "Almost there!";
    } else if (difference <= 10) {
      title = "Not Bad!";
    } else {
      title = "Are you even trying?";
    }
    return title;
  }
}