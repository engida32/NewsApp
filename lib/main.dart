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
      title:'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: Container(
            child: AnimatedDefaultTextStyle(child: Text("NEWS "), style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.blue,
            ),
             duration: const Duration( milliseconds :3000) ,),
          ),
          centered: true,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.blue,
          nextScreen: MainSreen(),
      ) 
      
    
    );
  }
}
