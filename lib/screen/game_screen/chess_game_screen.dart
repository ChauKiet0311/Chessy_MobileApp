import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:http/http.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'dart:convert';
import 'package:chessy/constant.dart' as globals;

class GameRoom extends StatefulWidget {
  final Map<String, dynamic> gameInfo;

  GameRoom({required this.gameInfo});

  @override
  State<StatefulWidget> createState() {
    return _GameRoom();
  }
}

class _GameRoom extends State<GameRoom> {
  ChessBoardController controller = ChessBoardController();

  void onConnect(StompFrame frame) {
    stompClient.subscribe(
        destination: '/topic/game-progress/' + widget.gameInfo['gameId'],
        callback: (StompFrame frame) {
          Map<String, dynamic> obj = json.decode(frame.body!);
          String message = obj['message'];

          String headerMessage = message.split(' ').elementAt(0);

          if (headerMessage == "MOVE") {
            String fen = obj['fen'];
            controller.loadFen(fen);
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

  String playerPosition = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Chessy")),
        body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage('image/167.jpg'), fit: BoxFit.cover)),
          child: Center(
              child: Column(
            children: [
              ChessBoard(
                controller: controller,
                onMove: () async {
                  String currentFen = controller.getFen();
                  String currentPlayer1 = widget.gameInfo['player1'];
                  String currentPlayer2 = widget.gameInfo['player2'];
                  String currentGameId = widget.gameInfo['gameId'];
                  Map<String, String> headers = {
                    HttpHeaders.contentTypeHeader: "application/json",
                    HttpHeaders.authorizationHeader:
                        globals.currentUser.refreshToken as String
                  };
                  String json_post =
                      '{"player1":"$currentPlayer1","player2":"$currentPlayer2","fen":"$currentFen","gameID":"$currentGameId","message": "MOVE"}';
                  Response response = await post(
                      Uri.https(globals.API, globals.GAMEPLAY_API),
                      headers: headers,
                      body: json_post);
                },
              ),
            ],
          )),
        ));
  }
}
