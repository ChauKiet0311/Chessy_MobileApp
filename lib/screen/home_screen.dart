import 'package:chessy/components/rounded_button.dart';
import 'package:chessy/screen/login_screen.dart';
import 'package:chessy/screen/signup_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Chessy")),
        body: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage('image/167.jpg'),
                    fit: BoxFit.cover)),
            child: Center(
                child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Image.asset(
                  'image/chessy_logo.png',
                  scale: 1.3,
                ),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedButton("Sign in", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    }),
                    const SizedBox(
                      width: 30,
                    ),
                    RoundedButton("Sign up", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    })
                  ],
                ))
              ],
            ))));
  }
}
