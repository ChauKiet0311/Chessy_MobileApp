import 'dart:convert';
import 'dart:io';

import 'package:chessy/screen/system_setting/system_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:chessy/components/rounded_button_bold.dart';
import 'package:chessy/components/logout_dialog.dart';
import 'package:http/http.dart';
import 'change_password_screen.dart';
import 'edit_screen.dart';
import 'history_screen.dart';
import 'package:chessy/constant.dart' as globals;

class SettingTabView extends StatefulWidget {
  @override
  State<SettingTabView> createState() {
    return _SettingTabView();
  }
}

class _SettingTabView extends State<SettingTabView> {
  void _handleLogout() {
    Navigator.of(context, rootNavigator: true).pop(context);
  }

  Map<String, dynamic> userFetchInfo = Map<String, dynamic>();

  void loadUserInfo() async {
    String currentUser = globals.currentUser.username as String;

    String refreshToken = globals.currentUser.refreshToken as String;

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + refreshToken,
      HttpHeaders.accessControlAllowOriginHeader: "*",
      'Accept': '*/*'
    };

    Response response = await get(
        Uri.https(globals.API, globals.GET_USER_API + currentUser),
        headers: headers);

    if (response.statusCode == 200) {
      userFetchInfo = jsonDecode(response.body);
      // print(userFetchInfo['name']);

      if (userFetchInfo['avatarURL'] != null) {
        globals.avatarURL = userFetchInfo['avatarURL'];
        globals.userEmail = userFetchInfo['email'];
        print(globals.avatarURL);
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();

    loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "SETTING",
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Colors.white),
        ),
        SizedBox(height: 30),
        CircleAvatar(
          radius: 70,
          backgroundImage: Image.network(
            globals.avatarURL,
          ).image,
        ),
        SizedBox(height: 40),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: RoundedButtonBold(
                "History",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => HistoryScreen(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: RoundedButtonBold(
                "Edit Profile",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => EditScreen(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: RoundedButtonBold(
                "Change Password",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => ChangePasswordScreen(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: RoundedButtonBold(
                "System Setting",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => SystemSettingScreen(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: RoundedButtonBold(
                "Log out",
                () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LogoutDialog(
                        onLogout: _handleLogout,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
