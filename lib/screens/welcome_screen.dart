import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:u_go/button.dart';
import 'package:u_go/constants.dart';
import 'package:u_go/screens/registration_screen.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {

  static String screenID = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

const colorizeColors = [
  kBackgroundColor,
  kLightColor,
  kButtonColor,
];




class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightColor,
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          SizedBox(
          width: 250.0,
          child: Center(
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'U Go',
                  textStyle: GoogleFonts.notoSans(fontSize: 75.0,),
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'Trust',
                  textStyle: GoogleFonts.notoSans(fontSize: 75.0,),
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'Comfort',
                  textStyle: GoogleFonts.notoSans(fontSize: 75.0,),
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'Security',
                  textStyle: GoogleFonts.notoSans(fontSize: 75.0,),
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: true,
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ),
            SizedBox(
              height: 50.0,
            ),
            Hero(
                tag: 'login_button',
                child: Button(
                  colour: kButtonColor,
                  text: 'Sign in',
                  onTouch: () {
                    Navigator.pushNamed(context, LoginScreen.screenID);
                    },
                ),
            ),
            Hero(
                tag: 'registration_button',
                child: Button(
                  colour: kBackgroundColor,
                  text: 'Sign up',
                  onTouch: () {
                    Navigator.pushNamed(context, RegistrationScreen.screenID);
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}

