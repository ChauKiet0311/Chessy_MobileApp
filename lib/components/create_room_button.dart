import 'package:flutter/material.dart';

class CreateRoomButton extends StatelessWidget {
  final VoidCallback press;
  final String name;

  CreateRoomButton(this.name, this.press, {super.key});

  String assetsName() {
    if (name == "Normal Match") {
      return "image/normal_match_icon.png";
    } else if (name == "Puzzle") {
      return "image/puzzle_icon.png";
    } else if (name == "Blitz Match") {
      return "image/blitz_icon.png";
    } else if (name == "Blitz 10") {
      return "image/blitz_10_icon.png";
    }
    return "image/normal_match_icon.png";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: InkWell(
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(30),
              width: 170,
              height: 170,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 249, 216, 244),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(children: [
                Image.asset(
                  assetsName(),
                  fit: BoxFit.contain,
                  height: 80,
                  width: 80,
                ),
                Text(name,
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromARGB(255, 90, 49, 92)))
              ]),
            )));
  }
}
