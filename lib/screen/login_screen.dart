import 'dart:convert';
import 'dart:io';

import 'package:chessy/components/input_textfield.dart';
import 'package:chessy/components/rounded_button.dart';
import 'package:chessy/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:chessy/constant.dart' as globals;
import 'package:material_dialogs/material_dialogs.dart';
import 'package:quickalert/quickalert.dart';
import 'package:chessy/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  Future<Map<String, dynamic>> checkLogin(
      String username, String password) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          globals.currentUser.refreshToken as String,
      HttpHeaders.accessControlAllowOriginHeader: "*",
      'Accept': '*/*'
    };
    String post_json = '{"username": "$username", "password": "$password"}';

    Map<String, dynamic> map = Map();

    Response response = await post(Uri.https(globals.API, globals.LOGIN_API),
        headers: headers, body: post_json);

    int statusCode = response.statusCode;
    if (statusCode == 200) {
      String json_response = response.body;
      map = jsonDecode(json_response);
      globals.currentUser.accessToken = (map['accessToken']);
      globals.currentUser.refreshToken = map['refreshToken'];
      globals.currentUser.username = username;
      map['message'] = "Success";
      return map;
    } else {
      map['message'] = "FAILED";
      return map;
    }
  }

  //Ở đây sẽ handle logic Login
  void handleLogin() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Fetching your data',
    );
    Map<String, dynamic> map = await checkLogin(
        usernameTextController.text, passwordTextController.text);
    String message = map['message'];
    if (message == 'Success') {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: "Login success",
        onConfirmBtnTap: () => {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
              (Route<dynamic> route) => false)
        },
      );
    } else {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: "Username or password in correct");
    }
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
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
            ),
            title: const Text("Chessy")),
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
                InputTextField(
                  "Username",
                  usernameTextController,
                  false,
                ),
                InputTextField(
                  "Password",
                  passwordTextController,
                  true,
                ),
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
