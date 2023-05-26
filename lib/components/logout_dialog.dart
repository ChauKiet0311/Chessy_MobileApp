import 'package:flutter/material.dart';
import 'package:chessy/components/rounded_button_bold_for_dialog.dart';

class LogoutDialog extends StatelessWidget {
  final Function() onLogout;

  const LogoutDialog({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: const Color(0xFFF9D8F4), // Thay đổi màu nền dialog
      title: Text(
        "Alert",
        style: TextStyle(
          color: const Color(0xFF5A315C),
          fontFamily: 'Montserrat',
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
      content: Container(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "You are about to log out, are you sure you want to log out?",
          style: TextStyle(
            color: const Color(0xFF5A315C),
            fontFamily: 'Montserrat',
            fontSize: 16,
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: RoundedButtonBoldDialog(
                "Log out",
                () {
                  onLogout();
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: RoundedButtonBoldDialog(
                "Go back",
                () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      contentTextStyle: TextStyle(
        fontSize: 16,
      ),
    );
  }
}
