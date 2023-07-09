import 'package:flutter/material.dart';
import 'package:chessy/components/rounded_button_bold_for_dialog.dart';
import 'package:chessy/screen/login_screen.dart';

class LogoutDialog extends StatelessWidget {
  final Function() onLogout;

  const LogoutDialog({Key? key, required this.onLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: const Color(0xFFF9D8F4), // Thay đổi màu nền dialog
      title: const Text(
        "Alert",
        style: TextStyle(
          color: Color(0xFF5A315C),
          fontFamily: 'Montserrat',
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
      content: Container(
        padding: const EdgeInsets.all(20.0),
        child: const Text(
          "You are about to log out, are you sure you want to log out?",
          style: TextStyle(
            color: Color(0xFF5A315C),
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const LoginScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
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
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      contentTextStyle: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
