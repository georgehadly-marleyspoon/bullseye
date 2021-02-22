import 'package:flutter/material.dart';

class HiteMeButton extends StatelessWidget {
  HiteMeButton({@required this.text, @required this.onPressed});

  final String text;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.red[700],
      splashColor: Colors.redAccent,
      onPressed: onPressed,
      shape: RoundedRectangleBorder (
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: Colors.white)
      ),
      child:
      Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
            text,
            maxLines: 1,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0
            )
        )
      ),
    );
  }
}