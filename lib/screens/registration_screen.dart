import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:u_go/screens/otp_screen.dart';

import '../button.dart';
import '../constants.dart';
import '../textfield.dart';


class RegistrationScreen extends StatefulWidget {
  static String screenID = 'welcome_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  String phoneNumber;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightColor,
      body: Center(
        child: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            backgroundColor: kLightColor,
          ),
          inAsyncCall: false,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    hintText: 'Enter phone number',
                    focus: kBackgroundColor,
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    phoneType: true,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  // CustomTextField(
                  //   hintText: 'Enter password',
                  //   onChanged: (value) {
                  //     otp = value;
                  //   },
                  //   phoneType: false,
                  // ),
                  Flexible(
                    child: Hero(
                      tag: 'registration_button',
                      child: Button(
                        colour: kBackgroundColor,
                        text: 'Sign up',
                        onTouch: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(phoneNumber: '+91'+phoneNumber,)));
                        },

                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
