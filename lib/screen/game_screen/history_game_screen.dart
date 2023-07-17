import 'package:chessy/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:quickalert/quickalert.dart';

class HistoryGameScreen extends StatefulWidget {
  List<dynamic> gameHistory;

  HistoryGameScreen({super.key, required this.gameHistory});

  @override
  State<StatefulWidget> createState() {
    return _HistoryGameScreen();
  }
}

class _HistoryGameScreen extends State<HistoryGameScreen> {
  ChessBoardController controller = ChessBoardController();

  int maxIndex = 0;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    maxIndex = widget.gameHistory.length - 1;
    currentIndex = -1;
  }

  void showNextMove() {
    if (currentIndex > maxIndex) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: 'Final Moves Already!!',
        text: 'This is the end of the game!',
      );
    } else {
      currentIndex += 1;
      String fen = widget.gameHistory[currentIndex]['fen'];
      controller.loadFen(fen);
    }
  }

  void showPreviousMove() {
    if (currentIndex < 0) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: 'First Moves Already!!',
        text: 'This is the start of the game!',
      );
    } else {
      currentIndex -= 1;
      String fen = widget.gameHistory[currentIndex]['fen'];
      controller.loadFen(fen);
    }
  }

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
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton("Previous Moves", () {
                      showPreviousMove();
                    }),
                    RoundedButton("Next Moves", () {
                      showNextMove();
                    }),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                RoundedButton("Back", () {
                  Navigator.of(context, rootNavigator: true).pop(context);
                })
              ],
            ),
          ),
        ));
  }
}
