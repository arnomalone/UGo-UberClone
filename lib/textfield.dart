import 'package:flutter/material.dart';
import 'package:u_go/constants.dart';

class CustomTextField extends StatelessWidget {

  final String hintText;
  final Function onChanged;
  final bool phoneType;
  final Color focus;

  CustomTextField({this.hintText, this.onChanged, this.phoneType, this.focus});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: kTextFieldCursorColor,
      keyboardType: this.phoneType ? TextInputType.phone : TextInputType.text,
      textAlign: TextAlign.center,
      onChanged: this.onChanged,
      decoration: InputDecoration(
        hintText: this.hintText,
        contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        fillColor: kDarkColor,
        hoverColor: kDarkColor,
        focusColor: kDarkColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: BorderSide(
            color: kLightColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: BorderSide(
            color: this.focus,
          ),
        ),
      ),
    );
  }
}
