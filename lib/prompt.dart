import 'package:flutter/material.dart';
import 'textstyle.dart';

class Prompt extends StatelessWidget {
  Prompt({@required this.targetValue});
  final int targetValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            "Put this Text as close as you can TO",
            style: LabelTextStyle.bodyText1(context)
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              "$targetValue",
              style: TargetTextStyle.headline4(context)
          ),
        ),
      ],
    );
  }
}