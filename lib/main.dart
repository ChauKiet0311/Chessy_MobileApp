import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chessy/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chessy',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
          appBar: AppBar(title: const Text('Chessy')),
          body: AnimatedSplashScreen(
            splash: 'image/chessy_logo.png',
            nextScreen: const HomeScreen(),
            splashIconSize: 250,
            splashTransition: SplashTransition.slideTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: const Color.fromARGB(255, 156, 100, 201),
          )),
    );
  }
}
