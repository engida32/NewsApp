import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Screens/main-screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          duration: 3000,
          splash: Text(
            
            "WORLD NEWS  ",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 33,
                fontStyle: FontStyle.italic,
                color: Colors.red.shade300,
                fontWeight: FontWeight.w900),
          ),
          curve: Curves.easeInOutCirc,
          centered: true,
          splashIconSize: 35,
          splashTransition: SplashTransition.rotationTransition,
          backgroundColor: Colors.indigo.shade300,
          nextScreen: MainSreen(),
        ));
  }
}
