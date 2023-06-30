import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:http/http.dart';
import 'package:quickalert/quickalert.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'dart:convert';
import 'package:chessy/constant.dart' as globals;

class GameRoom extends StatefulWidget {
  final Map<String, dynamic> gameInfo;

  GameRoom({required this.gameInfo});

  bool isMoveAble = false;
  String playerPosition = "";
  String currentGameSide = "W";

  @override
  State<StatefulWidget> createState() {
    return _GameRoom();
  }
}

class _GameRoom extends State<GameRoom> {
  ChessBoardController controller = ChessBoardController();

  bool isAnnoucePlayeSideOn = false;

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

            //Nhận về ở bên kia là hiện tại ở phía bên người mới gửi nhưng mà cả hai đều nhận được
            // Vì vậy phải set ngược lại ngay khi vừa mới gửi xong
            widget.currentGameSide = obj['currentSide'] == "W" ? "B" : "W";

            //Sau đó kiểm tra rằng bên nào sẽ được đi và không được đi
            setState(() {
              widget.isMoveAble = isThisSideFreeze();
            });
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

  bool isThisSideFreeze() {
    if (widget.playerPosition == widget.currentGameSide) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    stompClient.activate();

    String player1 = widget.gameInfo['player1'];
    String player2 = widget.gameInfo['player2'];

    if (globals.currentUser.username == player1) {
      widget.playerPosition = "W";
    } else {
      widget.playerPosition = "B";
    }
    widget.isMoveAble = isThisSideFreeze();
  }

  @override
  Widget build(BuildContext context) {
    if (!isAnnoucePlayeSideOn) {
      Future.delayed(Duration.zero, () {
        String currentSideAnnouce = widget.playerPosition;
        QuickAlert.show(
            context: context,
            type: QuickAlertType.info,
            text: 'You are on the $currentSideAnnouce side!',
            confirmBtnText: "Okay",
            onConfirmBtnTap: () => Navigator.pop(context));
      });
      isAnnoucePlayeSideOn = true;
    }

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
              IgnorePointer(
                ignoring: widget.isMoveAble,
                child: ChessBoard(
                  boardOrientation: widget.playerPosition == "W"
                      ? PlayerColor.white
                      : PlayerColor.black,
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

                    String currentSide_send = widget.playerPosition;

                    String json_post =
                        '{"player1":"$currentPlayer1","player2":"$currentPlayer2","fen":"$currentFen","gameID":"$currentGameId","message": "MOVE","currentSide":"$currentSide_send"}';
                    Response response = await post(
                        Uri.https(globals.API, globals.GAMEPLAY_API),
                        headers: headers,
                        body: json_post);
                  },
                ),
              ),
            ],
          )),
        ));
  }
}
