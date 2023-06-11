import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  WaitingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WaitingScreen();
  }
}

class _WaitingScreen extends State<WaitingScreen> {
  _WaitingScreen() {}

  Text customText(String name) {
    return Text(
      name,
      style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Chessy")),
        body: Container(
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage('image/167.jpg'),
                    fit: BoxFit.cover)),
            child: Center(
                child: Column(children: [
              Text(
                "WAITING ROOM",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                "Room ID: #12345",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.white),
              ),
            ]))));
  }
}
