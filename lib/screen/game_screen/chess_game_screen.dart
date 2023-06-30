import 'dart:io';

import 'package:chessy/components/rounded_button.dart';
import 'package:chessy/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:http/http.dart';
import 'package:quickalert/quickalert.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'dart:convert';
import 'package:chessy/constant.dart' as globals;
import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_controller.dart';

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
  CountdownController movesController = CountdownController(autoStart: true);

  bool isAnnoucePlayeSideOn = false;
  bool isOnFirstTimer = false;
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: globals.currentUser.refreshToken as String
  };

  //Xử lý các gói tin được gửi thông qua socket ở đây
  void onConnect(StompFrame frame) {
    stompClient.subscribe(
        destination: '/topic/game-progress/' + widget.gameInfo['gameId'],
        callback: (StompFrame frame) {
          Map<String, dynamic> obj = json.decode(frame.body!);
          String message = obj['message'];

          String headerMessage = message.split(' ').elementAt(0);

          if (headerMessage == "MOVE") {
            isOnFirstTimer = true;
            String fen = obj['fen'];
            controller.loadFen(fen);

            //Nhận về ở bên kia là hiện tại ở phía bên người mới gửi nhưng mà cả hai đều nhận được
            // Vì vậy phải set ngược lại ngay khi vừa mới gửi xong
            widget.currentGameSide = obj['currentSide'] == "W" ? "B" : "W";

            String currentSideAnnouce =
                widget.currentGameSide == "W" ? "White" : "Black";

            QuickAlert.show(
                context: context,
                type: QuickAlertType.info,
                text: 'This is $currentSideAnnouce Move!',
                confirmBtnText: "Okay",
                onConfirmBtnTap: () => Navigator.pop(context));

            //Sau đó kiểm tra rằng bên nào sẽ được đi và không được đi
            setState(() {
              widget.isMoveAble = isThisSideFreeze();
            });
          } else {
            if (message == "SYSTEM FINISH") {
              stompClient.deactivate();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (Route<dynamic> route) => false);
            }
            if (message == "SURRENDER") {
              String currentPlayer =
                  widget.playerPosition == "W" ? 'player1' : 'player2';

              if (obj[currentPlayer] == "NULL") {
                stompClient.deactivate();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                    (Route<dynamic> route) => false);
              } else {
                stompClient.deactivate();
                String currentGameId = widget.gameInfo['gameId'];
                finishGame();
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.info,
                    text: 'Your Opponent Surrender',
                    confirmBtnText: "Okay",
                    onConfirmBtnTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                          (Route<dynamic> route) => false);
                    });
              }
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

  bool isThisSideFreeze() {
    if (widget.playerPosition == widget.currentGameSide) {
      movesController.restart();
      movesController.start();
      //Lượt của đối thủ
      return false;
    }

    //Đây là khi mà lượt của mình
    movesController.pause();
    return true;
  }

  void finishGame() async {
    String currentGameId = widget.gameInfo['gameId'];
    String json_post = '{"gameId":"$currentGameId"}';

    Response response = await post(Uri.https(globals.API, globals.FINISH_API),
        headers: headers, body: json_post);
  }

  void overtimeFinish(BuildContext context) async {
    //kết thúc game
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          globals.currentUser.refreshToken as String
    };
    String currentGameId = widget.gameInfo['gameId'];
    String json_post = '{"gameId":"$currentGameId"}';

    Response response = await post(Uri.https(globals.API, globals.FINISH_API),
        headers: headers, body: json_post);

    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'You have run out of time! You lost',
        confirmBtnText: "Okay",
        onConfirmBtnTap: () {
          Navigator.pop(context);
        });
  }

  @override
  void initState() {
    super.initState();
    stompClient.activate();

    String player1 = widget.gameInfo['player1'];
    String player2 = widget.gameInfo['player2'];

    if (globals.currentUser.username == player1) {
      widget.playerPosition = "W";
      isOnFirstTimer = true;
    } else {
      widget.playerPosition = "B";
      movesController.pause();
      isOnFirstTimer = false;
    }
    widget.isMoveAble = isThisSideFreeze();
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
                    movesController.pause();
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
              isOnFirstTimer
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        customText("Your time this move"),
                        Countdown(
                          seconds: int.parse(widget.gameInfo['secsPerMoves']),
                          build: (_, double time) =>
                              customText(time.toString()),
                          interval: Duration(milliseconds: 100),
                          controller: movesController,
                          onFinished: () async {
                            overtimeFinish(context);
                          },
                        ),
                      ],
                    )
                  : customText("Please Wait for the first user go!"),
              SizedBox(
                height: 20,
              ),
              Center(
                child: RoundedButton("Surrender", () {
                  QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      text: 'Do you want to surrender?!',
                      confirmBtnText: "Okay",
                      onConfirmBtnTap: () async {
                        String currentSide_send = widget.playerPosition;
                        String currentGameId = widget.gameInfo['gameId'];
                        String currentPlayer1 = widget.gameInfo['player1'];
                        String currentPlayer2 = widget.gameInfo['player2'];
                        String post_json = "";
                        if (widget.playerPosition == "W") {
                          post_json =
                              '{"player1":"NULL","player2":"$currentPlayer2","gameID":"$currentGameId","message": "SURRENDER","currentSide":"$currentSide_send"}';
                        } else {
                          post_json =
                              '{"player1":"$currentPlayer1","player2":"NULL","gameID":"$currentGameId","message": "SURRENDER","currentSide":"$currentSide_send"}';
                        }

                        Response response = await post(
                            Uri.https(globals.API, globals.GAMEPLAY_API),
                            headers: headers,
                            body: post_json);
                        Navigator.pop(context);
                      });
                }),
              )
            ],
          )),
        ));
  }
}
