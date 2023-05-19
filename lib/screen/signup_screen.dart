import 'package:chessy/components/input_textfield.dart';
import 'package:chessy/components/rounded_button.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> {
  final usernameTextControler = TextEditingController();
  final passwordTextControler = TextEditingController();
  final repasswordTextControler = TextEditingController();
  final emailTextControler = TextEditingController();
  final nameTextControler = TextEditingController();

  @override
  void dispose() {
    usernameTextControler.dispose();
    passwordTextControler.dispose();
    repasswordTextControler.dispose();
    emailTextControler.dispose();
    nameTextControler.dispose();
    super.dispose();
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SIGN UP",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: Colors.white),
                ),
                InputTextField("Username", usernameTextControler),
                InputTextField("Password", passwordTextControler),
                InputTextField("Re-Enter Password", repasswordTextControler),
                InputTextField("Email", emailTextControler),
                InputTextField("Name", nameTextControler),
                RoundedButton("Submit", () {})
              ],
            )));
  }
}
