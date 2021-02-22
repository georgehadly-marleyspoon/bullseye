import 'package:Bullseye/models/gamemodel.dart';
import 'package:Bullseye/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:Bullseye/sliderthumbimage.dart';
import 'dart:typed_data';

class Control extends StatefulWidget {
  Control({Key key, @required this.model}) : super(key: key);
  final GameModel model;

  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  double _min = 1.0;
  double _max = 100.0;

  ui.Image _sliderImage;
  Future<ui.Image> _load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
  
  @override
  void initState() {
    _load("images/nub.png").then((image){
      setState(() {
        _sliderImage = image;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 90.0),
          child: Text(
            "$_min",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(activeTrackColor: Colors.red[700],
                  inactiveTrackColor: Colors.red[700],
                  trackShape: RoundedRectSliderTrackShape(),
                  trackHeight: 8.0,
                  thumbColor: Colors.redAccent,
                  thumbShape: SliderThumbImage(_sliderImage),
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            ),
            child: Slider(
                value: widget.model.current.toDouble(),
                min: this._min,
                max: this._max,
                onChanged: (newValue) {
                  setState(() {
                    this.widget.model.current = newValue.toInt();
                  });
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 64.0),
          child: Text(
              "$_max",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}