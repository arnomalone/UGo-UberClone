import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:u_go/data%20handlers/app_data.dart';
import 'package:u_go/screens/dashboard.dart';
import 'package:u_go/screens/login_screen.dart';
import 'package:u_go/screens/otp_screen.dart';
import 'package:u_go/screens/searchScreen.dart';
import 'package:u_go/screens/welcome_screen.dart';
import 'package:u_go/screens/registration_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'UGo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // initialRoute: WelcomeScreen.screenID,
        // home: WelcomeScreen(),
        home: DashBoard(),
        routes: {
          WelcomeScreen.screenID : (context) => WelcomeScreen(),
          LoginScreen.screenID : (context) => LoginScreen(),
          RegistrationScreen.screenID : (context) => RegistrationScreen(),
          OTPScreen.screenID : (context) => OTPScreen(),
          DashBoard.screenID : (context) => DashBoard(),
          SearchScreen.screenId : (context) => SearchScreen(),
        },
      ),
    );
  }
}