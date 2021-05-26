import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:u_go/button.dart';
import 'package:u_go/constants.dart';
import 'package:u_go/textfield.dart';

class LoginScreen extends StatefulWidget {
  static String screenID = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: kLightColor,
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            backgroundColor: kLightColor,
          ),
          inAsyncCall: false,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  hintText: 'Enter phone',
                  focus: kButtonColor,
                  onChanged: (value) {},
                  phoneType: true,
                ),
                SizedBox(
                  height: 8.0,
                ),
                CustomTextField(
                  hintText: 'Enter password',
                  focus: kButtonColor,
                  onChanged: (value) {},
                  phoneType: false,
                ),
                Flexible(
                  child: Hero(
                    tag: 'login_button',
                    child: Button(
                      colour: kButtonColor,
                      text: 'Sign in',
                      onTouch: () {},
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
