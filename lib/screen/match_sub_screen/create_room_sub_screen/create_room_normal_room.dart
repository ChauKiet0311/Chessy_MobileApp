import "package:chessy/components/create_room_button.dart";
import "package:chessy/components/input_textfield.dart";
import "package:chessy/components/rounded_button.dart";
import "package:chessy/screen/match_sub_screen/create_room_sub_screen/waiting_room.dart";
import "package:flutter/material.dart";

class CreateNormalRoomScreen extends StatefulWidget {
  final String mode;

  const CreateNormalRoomScreen({super.key, required this.mode});

  @override
  State<StatefulWidget> createState() {
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
      style: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: Colors.white),
    );
  }

  bool isFieldFull() {
    if (roomNameTextController.text == "" ||
        timeStopTextController.text == "" ||
        secondsPerMoveTextController.text == "") {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
              const Text(
                "MATCH CONFIG",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
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
                  RoundedButton("Confirm", () {
                    if (isFieldFull()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WaitingScreen(
                                    roomName: roomNameTextController.text,
                                    secondsPerMove:
                                        secondsPerMoveTextController.text,
                                    timeStop: timeStopTextController.text,
                                  )));
                    } else {}
                  })
                ],
              )
            ]))));
  }
}
