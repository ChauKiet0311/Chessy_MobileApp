import 'dart:io';

import 'package:chessy/screen/otp_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:chessy/components/rounded_button_bold.dart';
import 'package:http/http.dart';
import 'package:quickalert/quickalert.dart';
import '../components/edit_textfield.dart';
import 'package:chessy/constant.dart' as globals;

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final userNameTextController = TextEditingController();
  final oldPasswordTextController = TextEditingController();
  final newPasswordTextController = TextEditingController();
  final reEnterPasswordTextController = TextEditingController();

  @override
  void dispose() {
    userNameTextController.dispose();
    oldPasswordTextController.dispose();
    newPasswordTextController.dispose();
    reEnterPasswordTextController.dispose();
    super.dispose();
  }

  void errorDialog(String message) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: message,
    );
  }

  void handleChangePassword() async {
    String inputUsername = userNameTextController.text;
    String oldPassword = oldPasswordTextController.text;
    String newPassword = newPasswordTextController.text;
    String reEnterPassword = reEnterPasswordTextController.text;

    //check inputUsername
    if (inputUsername != globals.currentUser.username) {
      //Output dialog không đúng
      errorDialog("Username is not valid");
    } else {
      if (newPassword != reEnterPassword) {
        //Output dialog hai mật khẩu khác nhau
        errorDialog("reEnter password is not match with the new password");
      } else {
        String refreshToken = globals.currentUser.refreshToken as String;
        Map<String, String> headers = {
          HttpHeaders.contentTypeHeader: "application/json",
          'Authorization': "Bearer " + refreshToken,
          HttpHeaders.accessControlAllowOriginHeader: "*",
          'Accept': '*/*'
        };

        //oldPass -> "password" in dictionary
        //newPass -> "email" in dictionary
        String post_json =
            '{"username":"$inputUsername","password":"$oldPassword","email":"$newPassword"}';

        Response response = await put(
          Uri.https(globals.API, globals.PUT_USER_API + "password"),
          headers: headers,
          body: post_json,
        );

        int statusCode = response.statusCode;
        print(response.body);
        if (statusCode == 200) {
          if (response.body == 'Current Password is not valid!') {
            errorDialog("Current Password is not valid!");
          } else {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.info,
              text: "Password has changed",
              onConfirmBtnTap: () {},
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('image/167.jpg'), fit: BoxFit.cover)),
            child: SafeArea(
              child: Center(
                  child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "CHANGE PASSWORD",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(
                          children: [
                            const SizedBox(height: 30),
                            EditTextField(
                              "UserName",
                              userNameTextController,
                              hint: 'Type in your user name',
                              icon: const Icon(Icons.lock),
                              obscure: false,
                            ),
                            const SizedBox(height: 15),
                            EditTextField(
                              "Old Password",
                              oldPasswordTextController,
                              hint: 'Type in your old password',
                              icon: const Icon(Icons.remove_red_eye_outlined),
                              obscure: true,
                            ),
                            const SizedBox(height: 15),
                            EditTextField(
                              "New Password",
                              newPasswordTextController,
                              hint: 'Type in your new password',
                              icon: const Icon(Icons.remove_red_eye_outlined),
                              obscure: true,
                            ),
                            const SizedBox(height: 15),
                            EditTextField(
                              "Re-Enter New Password",
                              reEnterPasswordTextController,
                              hint: 'Type in your email address',
                              icon: const Icon(Icons.remove_red_eye_outlined),
                              obscure: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: RoundedButtonBold(
                                "Back",
                                () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: RoundedButtonBold(
                                "Save",
                                () async {
                                  handleChangePassword();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                      ],
                    ))),
              )),
            )));
  }
}
