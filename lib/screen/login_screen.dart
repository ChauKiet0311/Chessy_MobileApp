import 'package:chessy/components/input_textfield.dart';
import 'package:chessy/components/rounded_button.dart';
import 'package:chessy/screen/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //Ở đây sẽ handle logic Login
  void handleLogin() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    //Hủy các controller binding với TextField khi widget không còn hiện nữa
    usernameTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Chessy")),
        body: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'image/167.jpg'), //File ảnh background là image/167.jpg
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "SIGN IN",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: Colors.white),
                ),
                InputTextField("Username", usernameTextController),
                InputTextField("Password", passwordTextController),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton("Login", () {
                  handleLogin();
                })
              ],
            )));
  }
}
