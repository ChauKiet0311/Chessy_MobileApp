// ignore_for_file: prefer_collection_literals, type_init_formals

import "dart:convert";
import "dart:io";

import "package:chessy/components/create_room_button.dart";
import "package:chessy/components/input_textfield.dart";
import "package:chessy/components/rounded_button.dart";
import "package:chessy/screen/match_sub_screen/create_room_sub_screen/waiting_room.dart";
import "package:flutter/material.dart";
import "package:chessy/constant.dart" as globals;
import "package:http/http.dart";

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

  bool isIgnoreInput = false;

  Future<Map<String, dynamic>> createRoomBackend() async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          globals.currentUser.refreshToken as String
    };

    String player = globals.currentUser.username as String;
    String roomName = roomNameTextController.text;
    String secsPerMoves = secondsPerMoveTextController.text;
    String timeAllowStop = timeStopTextController.text;

    String post_json =
        '{"player": "$player","roomName": "$roomName","secsPerMoves": "$secsPerMoves","timeAllowStop":"$timeAllowStop"}';

    Map<String, dynamic> map = Map();

    Response response = await post(Uri.https(globals.API, globals.CREATE_API),
        headers: headers, body: post_json);

    int statusCode = response.statusCode;

    if (statusCode == 200) {
      print(response.body);
      map = jsonDecode(response.body);
      map['message'] = "Success";
    } else {
      map['message'] = "Failed";
    }

    return map;
  }

  //Show dialog
  progressDialogue(BuildContext context) {
    //set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(onWillPop: () async => false, child: alert);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    String currentUsername = globals.currentUser.username as String;
    roomNameTextController.text = currentUsername + "'s Room";

    if (widget.mode == "Normal Match") {
      isIgnoreInput = false;
    } else {
      isIgnoreInput = true;

      switch (mode) {
        case "Blitz Match":
          {
            secondsPerMoveTextController.text = "15";
            timeStopTextController.text = "300";
          }
          break;
        case "Blitz 10":
          {
            secondsPerMoveTextController.text = "15";
            timeStopTextController.text = "600";
          }
          break;
      }
    }
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
              IgnorePointer(
                  ignoring: isIgnoreInput,
                  child: InputTextField(
                      "RoomName", roomNameTextController, false)),
              IgnorePointer(
                ignoring: isIgnoreInput,
                child: InputTextField(
                    "Seconds per move", secondsPerMoveTextController, false),
              ),
              IgnorePointer(
                ignoring: isIgnoreInput,
                child: InputTextField(
                    "Time allow to stop", timeStopTextController, false),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton("Back", () {
                    Navigator.of(context, rootNavigator: true).pop(context);
                  }),
                  RoundedButton("Confirm", () async {
                    if (isFieldFull()) {
                      progressDialogue(context);
                      Map<String, dynamic> map = await createRoomBackend();
                      if (map['message'] == 'Success') {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WaitingScreen(
                                      roomName: roomNameTextController.text,
                                      secondsPerMove:
                                          secondsPerMoveTextController.text,
                                      timeStop: timeStopTextController.text,
                                      userName: globals.currentUser.username
                                          as String,
                                      gameInfo: map,
                                    )));
                      }
                    } else {}
                  })
                ],
              )
            ]))));
  }
}
