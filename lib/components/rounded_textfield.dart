import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController textFieldControler;
  final bool obscureText;

  const RoundedTextField(this.textFieldControler,
      {Key? key, this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width * 0.9,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: TextField(
              controller: textFieldControler,
              obscureText: obscureText,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                      color: Colors.grey[800],
                      height: 1,
                      fontSize: 10,
                      fontFamily: 'Montserrat'),
                  hintText: "Type in your text",
                  fillColor: Colors.white70),
            )));
  }
}
