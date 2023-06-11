import "package:chessy/components/create_room_button.dart";
import "package:chessy/components/input_textfield.dart";
import "package:chessy/components/rounded_button.dart";
import "package:flutter/material.dart";

class CreateNormalRoomScreen extends StatefulWidget {
  String mode;

  CreateNormalRoomScreen({super.key, required this.mode});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreateNormalRoomScreen(mode);
  }
}

class _CreateNormalRoomScreen extends State<CreateNormalRoomScreen> {
  String mode;
  _CreateNormalRoomScreen(String this.mode);

  TextEditingController roomNameTextController = TextEditingController();
  TextEditingController secondsPerMoveTextController = TextEditingController();
  TextEditingController timeStopTextController = TextEditingController();

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
              SizedBox(height: 20),
              Text(
                "MATCH CONFIG",
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
              CreateRoomButton(mode, () {}),
              InputTextField("RoomName", roomNameTextController),
              InputTextField("Seconds per move", secondsPerMoveTextController),
              InputTextField("Time allow to stop", timeStopTextController),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton("Back", () {
                    Navigator.of(context, rootNavigator: true).pop(context);
                  }),
                  RoundedButton("Confirm", () {})
                ],
              )
            ]))));
  }
}
