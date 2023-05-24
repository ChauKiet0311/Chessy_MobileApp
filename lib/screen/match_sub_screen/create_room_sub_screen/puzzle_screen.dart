import "package:chessy/components/create_room_button.dart";
import "package:chessy/components/rounded_button.dart";
import "package:flutter/material.dart";
import "package:chessy/components/puzzle_room_card.dart";

class PuzzleScreen extends StatefulWidget {
  @override
  State<PuzzleScreen> createState() {
    return _PuzzleScreen();
  }
}

class _PuzzleScreen extends State<PuzzleScreen> {
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
                SizedBox(height: 20),
                Text(
                  "MATCH",
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
                SizedBox(height: 10),
                CreateRoomButton("Puzzle", () {}),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Puzzle Difficulty",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Colors.white),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton("Easy", () {}),
                        RoundedButton("Medium", () {}),
                        RoundedButton("Hard", () {})
                      ],
                    )),
                Padding(padding: EdgeInsets.all(10), child: PuzzleCard()),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton("Change", () {}),
                        RoundedButton("Play", () {})
                      ],
                    ))
              ]),
            )));
  }
}
