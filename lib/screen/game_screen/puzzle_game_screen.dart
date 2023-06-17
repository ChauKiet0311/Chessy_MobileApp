// ignore_for_file: unused_import, avoid_print

import 'dart:collection';

import 'package:chessy/components/rounded_button.dart';
import 'package:chessy/models/puzzleInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:material_dialogs/material_dialogs.dart';
import "package:material_dialogs/widgets/buttons/icon_outline_button.dart";
import 'package:quickalert/quickalert.dart';
import 'package:stack/stack.dart' as kStack;

class PuzzleGameRoom extends StatefulWidget {
  PuzzleInfo currentPuzzle = PuzzleInfo();
  PuzzleGameRoom({super.key, required this.currentPuzzle});
  @override
  State<StatefulWidget> createState() {
    return _PuzzleGameRoom(currentPuzzle);
  }
}

class _PuzzleGameRoom extends State<PuzzleGameRoom> {
  PuzzleInfo currentPuzzle = PuzzleInfo();
  _PuzzleGameRoom(this.currentPuzzle);

  ChessBoardController controller = ChessBoardController();
  ChessBoardController subController = ChessBoardController();

  Queue<String> moves_queue = Queue();
  List<BoardArrow> guide_arrow = [];

  void initQueue() {
    var moves_valid = currentPuzzle.Moves.split(' ');
    for (String moves in moves_valid) {
      moves_queue.add(moves);
    }
  }

  String getFirstMove(String FEN) {
    String character = FEN.split(' ').elementAt(1);
    if (character == "w") {
      return "White";
    } else
      return "Black";
  }

  String playerStatus = "";

  @override
  void initState() {
    super.initState();

    controller.loadFen(currentPuzzle.FEN);
    subController.loadFen(currentPuzzle.FEN);
    print("FEN input " + currentPuzzle.FEN);
    print(controller.getAscii());
    print("Cac buoc di: " + currentPuzzle.Moves);
    initQueue();

    //Nếu số nước đi để dẫn tới chiến thắng là một con số chẵn thì chúng ta sẽ phải đi nước đi đầu trước
    if (moves_queue.length % 2 == 0) {
      String currentMovesValid = moves_queue.first;
      String currentMovesValid_from = currentMovesValid.substring(0, 2);
      String currentMovesValid_to = currentMovesValid.substring(2, 4);

      subController.makeMove(
          from: currentMovesValid_from, to: currentMovesValid_to);
      controller.loadFen(subController.getFen());
      moves_queue.removeFirst();
    }

    playerStatus = getFirstMove(controller.getFen());
    print(playerStatus);
  }

  bool isGuideCheck = false;
  void makeGuide() {
    if (!isGuideCheck) {
      String currentMovesValid = moves_queue.first;

      String currentMovesValid_from = currentMovesValid.substring(0, 2);

      String currentMovesValid_to = currentMovesValid.substring(2, 4);

      BoardArrow boardArrow = BoardArrow(
          from: currentMovesValid_from,
          to: currentMovesValid_to,
          color: Colors.red.withOpacity(0.7));

      setState(() {
        guide_arrow = [boardArrow];
      });
      isGuideCheck = true;
    } else {
      setState(() {
        guide_arrow.removeAt(0);
        isGuideCheck = false;
      });
    }
  }

  bool isInfoDialogOn = false;

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;

    if (!isInfoDialogOn) {
      Future.delayed(Duration(seconds: 1), () {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.info,
            text: 'You are on the $playerStatus side!',
            confirmBtnText: "Okay",
            onConfirmBtnTap: () => Navigator.pop(context));
      });
      isInfoDialogOn = true;
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Chessy")),
        body: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage('image/167.jpg'), fit: BoxFit.cover)),
            child: Center(
                child: Column(children: [
              ChessBoard(
                controller: controller,
                boardColor: BoardColor.green,
                boardOrientation: PlayerColor.white,
                arrows: guide_arrow,
                onMove: () {
                  String currentFEN = controller.getFen();
                  String goBackFEN = subController.getFen();
                  String currentMovesValid = moves_queue.first;

                  String currentMovesValid_from =
                      currentMovesValid.substring(0, 2);

                  String currentMovesValid_to =
                      currentMovesValid.substring(2, 4);

                  print(currentMovesValid_from + ' ' + currentMovesValid_to);
                  subController.makeMove(
                      from: currentMovesValid_from, to: currentMovesValid_to);
                  String validFEN = subController.getFen();

                  if (currentFEN != validFEN) {
                    //Trường hợp đi sai, thì cho người chơi lựa chọn đi lại
                    //Đồng thời khôi phục lại

                    Dialogs.materialDialog(
                        context: context,
                        msg: "You went the wrong way!",
                        title: "Alert!!!",
                        actions: [
                          IconsOutlineButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(context);
                              Navigator.of(context, rootNavigator: true)
                                  .pop(context);
                            },
                            text: 'Quit',
                            iconData: Icons.cancel_outlined,
                            textStyle: const TextStyle(color: Colors.grey),
                            iconColor: Colors.grey,
                          ),
                          IconsOutlineButton(
                            onPressed: () {
                              //Nếu thử lại, trả lại các nước đi trước
                              controller.loadFen(goBackFEN);
                              subController.loadFen(goBackFEN);
                              print(controller.getFen());
                              Navigator.of(context, rootNavigator: true)
                                  .pop(context);
                            },
                            text: 'Retry',
                            iconData: Icons.cancel_outlined,
                            textStyle: const TextStyle(color: Colors.grey),
                            iconColor: Colors.grey,
                          )
                        ]);
                  } else {
                    //Nếu đi đúng thì phải pop queue
                    moves_queue.removeFirst();

                    if (moves_queue.isEmpty) {
                      //Nếu is empty tức là đã chiến thắng
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Congratulations!! You solved the puzzle',
                          onConfirmBtnTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                    } else {
                      //Nếu queue không empty, thì chúng ta chúc mừng người chơi và đi tiếp bước đi của máy
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Congratulations!! You go the right way',
                          onConfirmBtnTap: () {
                            //Sau khi bấm vô sẽ pop ra màn hình và đợi khoảng 2 giây để máy đi
                            Navigator.pop(context);
                          });
                      String currentBotMovesValid = moves_queue.first;

                      String currentBotMovesValid_from =
                          currentBotMovesValid.substring(0, 2);

                      String currentBotMovesValid_to =
                          currentBotMovesValid.substring(2, 4);

                      subController.makeMove(
                          from: currentBotMovesValid_from,
                          to: currentBotMovesValid_to);
                      controller.loadFen(subController.getFen());
                      moves_queue.removeFirst();
                    }
                  }
                },
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Image.asset(
                  "image/puzzle_represent.png",
                  color: playerStatus == "White" ? Colors.white : Colors.black,
                  width: screen_width * 0.3,
                  height: screen_height * 0.1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Turn",
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                    Text(
                      "Find the best move for $playerStatus",
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.white),
                    )
                  ],
                )
              ]),
              const SizedBox(height: 20),
              Row(
                children: [
                  RoundedButton("Guide", makeGuide),
                ],
              )
            ]))));
  }
}
