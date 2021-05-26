import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class Button extends StatelessWidget {

  final Color colour;
  final Function onTouch;
  final String text;

  Button({this.text, this.colour, this.onTouch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: this.colour,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: this.onTouch,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            this.text,
            style: TextStyle(
              color: kLightColor,
            ),
          ),
        ),
      ),
    );
  }
}