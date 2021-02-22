import 'package:Bullseye/about.dart';
import 'package:flutter/material.dart';
import 'textstyle.dart';
import 'styledbutton.dart';
import 'package:Bullseye/about.dart';

class Score extends StatelessWidget {

  Score({
    Key key,
    @required this.totalScore,
    @required this.round,
    @required this.onStartOver
  }) : super(key: key);

  final int totalScore;
  final int round;
  final VoidCallback onStartOver;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StyledButton(onPressed: () {
          onStartOver();
        },
          icon: Icons.refresh,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Column(
            children: [
              Text(
                "Score: ",
                style: LabelTextStyle.bodyText1(context),
              ),
              Text(
                  "$totalScore",
                style: ScoreNumberTextStyle.headline4(context),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Round: ",
                style: LabelTextStyle.bodyText1(context),
              ),
              Text(
                "$round",
                style: ScoreNumberTextStyle.headline4(context),
              )
            ],
          ),
        ),
        StyledButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage())
              );
            },
            icon: Icons.info,
        )
      ],
    );
  }
}