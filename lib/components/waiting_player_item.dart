import 'package:flutter/material.dart';

class WaitingPlayerCard extends StatefulWidget {
  const WaitingPlayerCard(
      {super.key, required this.profile, required this.status});

  final String status;
  final String profile;
  @override
  State<StatefulWidget> createState() {
    return _WaitingPlayerCard(profile);
  }
}

class _WaitingPlayerCard extends State<WaitingPlayerCard> {
  _WaitingPlayerCard(this.profile);
  String profile;

  Text customText(String name) {
    return Text(
      name,
      style: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Color.fromARGB(255, 233, 226, 234)),
      maxLines: 1,
    );
  }

  void changeStatus() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return profile == "YourProfile" ? cardProfile(size) : cardOpponent(size);
  }

  Card cardProfile(Size size) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      child: Container(
          padding: const EdgeInsets.all(10),
          width: size.width * 0.9,
          height: size.height * 0.15,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 105, 14, 91),
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "image/avatar.png",
                fit: BoxFit.contain,
                height: 50,
                width: 50,
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  customText("Quang Minh"),
                  const SizedBox(
                    height: 7,
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.status,
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Color.fromARGB(255, 233, 226, 234)),
                ),
              )
            ],
          )),
    );
  }

  Card cardOpponent(Size size) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      child: Container(
          padding: const EdgeInsets.all(10),
          width: size.width * 0.9,
          height: size.height * 0.15,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 129, 31, 134),
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.status,
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Color.fromARGB(255, 233, 226, 234)),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  customText("Quang Minh"),
                  const SizedBox(
                    height: 7,
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Image.asset(
                "image/avatar.png",
                fit: BoxFit.contain,
                height: 50,
                width: 50,
              ),
            ],
          )),
    );
  }
}
