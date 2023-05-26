import 'package:flutter/material.dart';

class RoundedButtonBold extends StatelessWidget {
  final String text;
  final VoidCallback press;

  const RoundedButtonBold(this.text, this.press, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: ElevatedButton(
        onPressed: press,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 129, 31, 134)),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 249, 216, 244)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(
                color: Color.fromARGB(255, 249, 216, 244),
              ),
            ),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width *
                  0.05, // Thay đổi kích thước chữ cho phù hợp với màn hình
            ),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
