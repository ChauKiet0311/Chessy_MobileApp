import 'package:chessy/screen/system_setting/system_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:chessy/components/rounded_button_bold.dart';
import 'package:chessy/components/logout_dialog.dart';
import 'change_password_screen.dart';
import 'edit_screen.dart';
import 'history_screen.dart';

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
            'https://i.imgur.com/wfH8Koa.png',
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
                  Navigator.push(context, MaterialPageRoute(
                    builder: (ctx) => HistoryScreen(),
                  ),);
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: RoundedButtonBold(
                "Edit Profile",
                () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (ctx) => EditScreen(),
                  ),);
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: RoundedButtonBold(
                "Change Password",
                () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (ctx) => ChangePasswordScreen(),
                  ),);
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: RoundedButtonBold(
                "System Setting",
                () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (ctx) => SystemSettingScreen(),
                  ),);
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
