// ignore_for_file: unused_import, avoid_print

import 'dart:collection';

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

  void initStack() {
    var moves_valid = currentPuzzle.Moves.split(' ');
    for (String moves in moves_valid) {
      moves_queue.add(moves);
    }
  }

  @override
  void initState() {
    super.initState();

    controller.loadFen(currentPuzzle.FEN);
    subController.loadFen(currentPuzzle.FEN);
    print("FEN input " + currentPuzzle.FEN);
    print(controller.getAscii());
    print("Cac buoc di: " + currentPuzzle.Moves);
    initStack();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: const Text("Chessy")),
        body: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage('image/167.jpg'), fit: BoxFit.cover)),
            child: Center(
                child: Column(children: [
              Expanded(
                  child: ChessBoard(
                controller: controller,
                boardColor: BoardColor.green,
                boardOrientation: PlayerColor.white,
                onMove: () {
                  String currentFEN = controller.getFen();
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
                              subController.undoMove();
                              controller.undoMove();
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
                    }
                  }
                },
              ))
            ]))));
  }
}
