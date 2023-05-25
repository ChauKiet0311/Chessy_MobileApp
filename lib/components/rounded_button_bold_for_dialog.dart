import 'package:flutter/material.dart';

class RoundedButtonBoldDialog extends StatelessWidget {
  final String text;
  final VoidCallback press;

  const RoundedButtonBoldDialog(this.text, this.press, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: ElevatedButton(
        onPressed: press,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFFF9D8F4)), // Thay đổi màu chữ
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF811F86)), // Thay đổi màu nền
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(
                color: Color(0xFF811F86),
              ),
            ),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
