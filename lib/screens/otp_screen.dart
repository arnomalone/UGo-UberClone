import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../button.dart';
import '../constants.dart';
import '../textfield.dart';

class OTPScreen extends StatefulWidget {

  static String screenID = 'otp_screen';
  final String phoneNumber;

  OTPScreen({this.phoneNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  final _auth = FirebaseAuth.instance;
  String otp;
  String status;
  String code;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVerification();
  }

  void getVerification () async {
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      code = verificationId;
      print('Code sent to ${widget.phoneNumber} // $code');
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      code = verificationId;
      print("\nAuto retrieval time out");
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print("Error message: " + authException.message);
      if (authException.message.contains('not authorized'))
        print('Something has gone wrong, please try later');
      else if (authException.message.contains('Network'))
        print('Please check your internet connection and try again');
      else
        print('Something has gone wrong, please try later');
    };
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {
      print('Auto retrieving verification code');
      PhoneAuthCredential _authCredential = auth;
      _auth
          .signInWithCredential(_authCredential)
          .then((value) {
        if (value.user != null) {
          print('Authentication successful');
          authenticationSuccessful();
        } else {
          print('Invalid code/invalid authentication');
        }
      }).catchError((error) {
        print('Something has gone wrong, please try later');
      });
    };
    _auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  authenticationSuccessful () {
    // Navigator.pushNamed(context, OTPScreen.screenID);
    Fluttertoast.showToast(
        msg: "Yessir",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
    );
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          backgroundColor: kLightColor,
        ),
        inAsyncCall: isLoading,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Enter OTP',
                onChanged: (value) {
                  otp = value;
                },
                phoneType: false,
              ),
              Flexible(
                child: Hero(
                  tag: 'registration_button',
                  child: Button(
                    colour: kButtonColor,
                    text: 'Sign up',
                    onTouch: () {

                      // Fluttertoast.showToast(
                      //   msg: "Yessir",
                      //   toastLength: Toast.LENGTH_SHORT,
                      //   gravity: ToastGravity.CENTER,
                      // );

                      void _signInWithPhoneNumber(String smsCode) async {
                        PhoneAuthCredential _authCredential = PhoneAuthProvider.credential(
                            verificationId: code, smsCode: smsCode);
                        _auth.signInWithCredential(_authCredential).catchError((error) {
                          setState(() {
                            status = 'Something has gone wrong, please try later';
                          });
                        }).then((user) async {
                            print('Authentication successful');
                            authenticationSuccessful();
                            return;
                        });
                      }
                      _signInWithPhoneNumber(otp);
                    },

                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
