import 'package:flutter/material.dart';
import 'package:chessy/components/waiting_player_item.dart';
import 'package:chessy/components/rounded_button.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen(
      {super.key,
      required this.roomName,
      required this.secondsPerMove,
      required this.timeStop});

  final String roomName;
  final String secondsPerMove;
  final String timeStop;
  @override
  State<StatefulWidget> createState() {
    return _WaitingScreen(roomName, secondsPerMove, timeStop);
  }
}

class _WaitingScreen extends State<WaitingScreen> {
  _WaitingScreen(this.roomname, this.secondsPerMove, this.timeStop) {}

  String roomname;
  String secondsPerMove;
  String timeStop;
  String yourStatus = "UNREADY";
  String OpponentStatus = "UNREADY";

  Text customText(String name) {
    return Text(
      name,
      style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Colors.white),
    );
  }

  void setYouStatus() {
    setState(() {
      if (yourStatus == "UNREADY") {
        yourStatus = "READY";
      } else {
        yourStatus = "UNREADY";
      }
    });
  }

  void setOppStatus() {
    setState(() {
      if (OpponentStatus == "UNREADY") {
        OpponentStatus = "READY";
      } else {
        OpponentStatus = "UNREADY";
      }
    });
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
              const SizedBox(height: 20),
              Text(
                "WAITING ROOM",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              customText("Room id #12345"),
              customText("Room name: $roomname"),
              customText("Seconds per move: $secondsPerMove"),
              customText("Time allow to stop: $timeStop"),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Your profile",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ),
              WaitingPlayerCard(
                profile: "YourProfile",
                status: yourStatus,
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Your opponent",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ),
              WaitingPlayerCard(
                profile: "OpponentProfile",
                status: OpponentStatus,
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton("Ready", () {
                    setYouStatus();
                  }),
                  RoundedButton("Play", () {})
                ],
              )
            ]))));
  }
}
