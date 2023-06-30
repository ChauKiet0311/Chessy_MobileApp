// ignore_for_file: import_of_legacy_library_into_null_safe, no_logic_in_create_state

import 'dart:io';

import 'package:chessy/screen/game_screen/chess_game_screen.dart';
import 'package:chessy/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:chessy/components/waiting_player_item.dart';
import 'package:chessy/components/rounded_button.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'dart:convert';
import 'package:chessy/constant.dart' as globals;
import "package:http/http.dart";

class WaitingScreen extends StatefulWidget {
  const WaitingScreen(
      {super.key,
      required this.roomName,
      required this.secondsPerMove,
      required this.timeStop,
      required this.userName,
      required this.gameInfo});

  final String roomName;
  final String userName;
  final String secondsPerMove;
  final String timeStop;
  final Map<String, dynamic> gameInfo;

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

  //Hàm này là mỗi khi socket trên server phát tín hiệu
  void onConnect(StompFrame frame) {
    stompClient.subscribe(
        destination: '/topic/game-progress/' + widget.gameInfo['gameId'],
        callback: (StompFrame frame) {
          Map<String, dynamic> obj = json.decode(frame.body!);
          String message = obj['message'];

          String headerMessage = message.split(' ').elementAt(0);
          print(headerMessage);
          //Khi mà nhận message yêu cầu chuyển trạng thái Ready
          if (headerMessage == 'READY') {
            String sendPlayer = message.split(' ').elementAt(1);
            if (sendPlayer != widget.userName) {
              setState(() {
                setOppStatus();
              });
            }
          } else if (headerMessage == "CONNECTING") {
            //Message thông báo rằng player2 đang connect vào
            String sendPlayer2 = obj['player2'];

            setState(() {
              widget.gameInfo['player2'] = sendPlayer2;
            });
          } else if (headerMessage == "STARTGAME") {
            print("Im in start");
            stompClient.deactivate();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GameRoom(gameInfo: widget.gameInfo)));
          } else if (headerMessage == "LEAVEGAME") {
            String sendPlayer = message.split(' ').elementAt(1);
            if (sendPlayer == widget.userName) {
              stompClient.deactivate();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (Route<dynamic> route) => false);
            } else {
              String sendPlayer2 = "WAITTING...";

              setState(() {
                widget.gameInfo['player2'] = sendPlayer2;
              });
            }
          }
        });
  }

  late StompClient stompClient = StompClient(
      config: StompConfig.SockJS(
    url: 'https://chessy-backend.onrender.com/gameplay',
    onConnect: (StompFrame frame) {
      onConnect(frame);
    },
    onWebSocketError: (dynamic error) => print(error.toString()),
  ));

  @override
  void initState() {
    super.initState();
    stompClient.activate();
  }

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

  void setYouStatus() async {
    String currentGameId = widget.gameInfo['gameId'];
    String currentUser = widget.userName;

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          globals.currentUser.refreshToken as String
    };

    String post_json =
        '{"gameID":"$currentGameId","message":"READY $currentUser"}';
    Response response = await post(Uri.https(globals.API, globals.GAMEPLAY_API),
        headers: headers, body: post_json);
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

  void startGame() async {
    String currentGameId = widget.gameInfo['gameId'];
    String currentUser = widget.userName;

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          globals.currentUser.refreshToken as String
    };

    String post_json = '{"gameID":"$currentGameId","message":"STARTGAME"}';
    Response response = await post(Uri.https(globals.API, globals.GAMEPLAY_API),
        headers: headers, body: post_json);
    print(response.body);
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
              customText("Room id #" + widget.gameInfo['gameId']),
              customText("Room name: " + widget.gameInfo['roomName']),
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
                userName: widget.gameInfo['player1'],
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
                userName: widget.gameInfo['player2'] == null
                    ? "NAME"
                    : widget.gameInfo['player2'],
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
                  RoundedButton("Play", () async {
                    if (OpponentStatus == "READY" && yourStatus == "READY") {
                      print("im here");
                      startGame();
                    }
                  })
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton("Leave", () async {
                    Map<String, String> headers = {
                      HttpHeaders.contentTypeHeader: "application/json",
                      HttpHeaders.authorizationHeader:
                          globals.currentUser.refreshToken as String
                    };

                    String currentGameId = widget.gameInfo['gameId'];
                    String currentUser = widget.userName;
                    String post_json =
                        '{"gameID":"$currentGameId","player1":"$currentUser","message":"LEAVEGAME $currentUser"}';

                    Response response = await post(
                        Uri.https(globals.API, globals.GAMEPLAY_API),
                        headers: headers,
                        body: post_json);

                    post_json =
                        '{"gameId":"$currentGameId","player":"$currentUser"}';
                    response = await post(
                        Uri.https(globals.API, globals.LEAVE_API),
                        headers: headers,
                        body: post_json);
                  })
                ],
              )
            ]))));
  }
}
