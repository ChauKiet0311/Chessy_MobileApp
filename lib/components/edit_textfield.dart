import 'package:flutter/material.dart';

class EditTextField extends StatelessWidget {
  final String nameField;
  final TextEditingController textFieldControler;
  final String hint;
  final Icon icon;

  const EditTextField(this.nameField, this.textFieldControler, {super.key, required this.hint, required this.icon});

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

        SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: TextField(
              controller: textFieldControler,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                      color: Colors.grey[800],
                      height: 1,
                      fontSize: 10,
                      fontFamily: 'Montserrat'),
                  hintText: hint,
                  suffixIcon: icon,
                  fillColor: const Color.fromARGB(255, 249, 216, 244)
              ),
            )))
      ],
    );
  }
}
