import 'package:flutter/material.dart';
import 'package:chessy/components/rounded_textfield.dart';

class InputTextField extends StatelessWidget {
  final String nameField;
  final TextEditingController textFieldControler;
  final bool obscureText;

  const InputTextField(
      this.nameField, this.textFieldControler, this.obscureText,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nameField,
          style: const TextStyle(fontFamily: 'Montserrat', color: Colors.white),
        ),
        RoundedTextField(textFieldControler, obscureText: obscureText)
      ],
    );
  }
}
