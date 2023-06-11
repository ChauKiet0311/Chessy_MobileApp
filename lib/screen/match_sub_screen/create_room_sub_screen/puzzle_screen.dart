import "dart:convert";
import "dart:math";

import "package:chessy/components/create_room_button.dart";
import "package:chessy/components/rounded_button.dart";
import "package:chessy/models/puzzleInfo.dart";
import "package:chessy/screen/game_screen/puzzle_game_screen.dart";
import "package:flutter/material.dart";
import "package:chessy/components/puzzle_room_card.dart";
import 'package:material_dialogs/material_dialogs.dart';
import "package:material_dialogs/widgets/buttons/icon_outline_button.dart";
import 'package:http/http.dart' as http;

class PuzzleScreen extends StatefulWidget {
  @override
  State<PuzzleScreen> createState() {
    return _PuzzleScreen();
  }
}

class _PuzzleScreen extends State<PuzzleScreen>
    with AutomaticKeepAliveClientMixin<PuzzleScreen> {
  List<PuzzleInfo> puzzleList_easy = [];
  List<PuzzleInfo> puzzleList_medium = [];
  List<PuzzleInfo> puzzleList_hard = [];

  static const int EASY_NUM_TABLE = 1100;
  static const int MEDIUM_NUM_TABLE = 1010;
  static const int HARD_NUM_TABLE = 1300;
  int current_mili_seconds = DateTime.now().millisecondsSinceEpoch;

  String currentMode = "";
  PuzzleInfo currentPuzzleInfo = PuzzleInfo();

  void annouceHaventChooseDialog() {
    Dialogs.materialDialog(
        context: context,
        msg: "You haven't choose any game to play!",
        title: "Alert!!!",
        actions: [
          IconsOutlineButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(context);
            },
            text: 'Cancel',
            iconData: Icons.cancel_outlined,
            textStyle: const TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          )
        ]);
  }

  PuzzleCard currentCard = PuzzleCard(
      PuzzleInfo(
          id: "-1",
          FEN: "-1",
          Moves: "-1",
          Popularity: -1,
          PuzzleId: "Unknown",
          rating: 0),
      "Unknow");

  @override
  bool get wantKeepAlive => true;

  int randomNumber(int range) {
    int result = 0;
    current_mili_seconds = DateTime.now().millisecondsSinceEpoch;
    Random random = Random(current_mili_seconds);
    result = random.nextInt(range);
    return result;
  }

  String randomTable(String mode) {
    String result = "";
    if (mode == "Easy") {
      int validRandomNumber = randomNumber(EASY_NUM_TABLE);
      result = "easy" + validRandomNumber.toString();
    } else if (mode == "Medium") {
      int validRandomNumber = randomNumber(MEDIUM_NUM_TABLE);
      result = "medium" + validRandomNumber.toString();
    } else if (mode == "Hard") {
      int validRandomNumber = randomNumber(HARD_NUM_TABLE);
      result = "hard" + validRandomNumber.toString();
    }

    return result;
  }

  Future<List<PuzzleInfo>> _loadPuzzles(String mode) async {
    List<PuzzleInfo> puzzleList = [];
    String json_file = randomTable(mode) + ".json";
    final url = Uri.https(
        'chessypuzzle-default-rtdb.asia-southeast1.firebasedatabase.app',
        json_file);
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    for (final item in listData.entries) {
      puzzleList.add(PuzzleInfo(
          PuzzleId: item.value['PuzzleId'],
          FEN: item.value['FEN'],
          Moves: item.value["Moves"],
          Popularity: item.value['Popularity'],
          rating: item.value["Rating"]));
    }

    return puzzleList;
  }

  void loadPuzzleState() async {
    if (puzzleList_easy.isEmpty) {
      puzzleList_easy = await _loadPuzzles("Easy");
      //print("Easy here");
    }

    if (puzzleList_medium.isEmpty) {
      puzzleList_medium = await _loadPuzzles("Medium");
      //print("Medium here");
    }

    if (puzzleList_hard.isEmpty) {
      puzzleList_hard = await _loadPuzzles("Hard");
      //print("Hard here");
    }
  }

  void chooseMode(String mode) {
    PuzzleInfo newPuzzleInfo = PuzzleInfo();
    int randomNumber = 0;
    current_mili_seconds = DateTime.now().millisecondsSinceEpoch;
    Random random = new Random(current_mili_seconds);
    if (mode == "Easy") {
      randomNumber = random.nextInt(puzzleList_easy.length);
      newPuzzleInfo = puzzleList_easy.elementAt(randomNumber);
    } else if (mode == "Medium") {
      randomNumber = random.nextInt(puzzleList_medium.length);
      newPuzzleInfo = puzzleList_medium.elementAt(randomNumber);
    } else if (mode == "Hard") {
      randomNumber = random.nextInt(puzzleList_hard.length);
      newPuzzleInfo = puzzleList_hard.elementAt(randomNumber);
    }
    setState(() {
      currentCard = new PuzzleCard(newPuzzleInfo, mode);
      currentMode = mode;
      currentPuzzleInfo = newPuzzleInfo;
    });
  }

  void playGame() {
    Dialogs.materialDialog(
      context: context,
      msg: "Are you sure you want to play?",
      title: "Alert!!!",
      actions: [
        IconsOutlineButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);
          },
          text: 'No',
          iconData: Icons.cancel_outlined,
          textStyle: const TextStyle(color: Colors.grey),
          iconColor: Colors.grey,
        ),
        IconsOutlineButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PuzzleGameRoom(
                          currentPuzzle: currentPuzzleInfo,
                        )));
          },
          text: 'Yes',
          iconData: Icons.cancel_outlined,
          textStyle: const TextStyle(color: Colors.grey),
          iconColor: Colors.grey,
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    loadPuzzleState();
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
                const Text(
                  "Choose Game",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Room ID: #12345",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                CreateRoomButton("Puzzle", () {}),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  "Puzzle Difficulty",
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Colors.white),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton("Easy", () {
                          chooseMode("Easy");
                        }),
                        RoundedButton("Medium", () {
                          chooseMode("Medium");
                        }),
                        RoundedButton("Hard", () {
                          chooseMode("Hard");
                        })
                      ],
                    )),
                Padding(padding: const EdgeInsets.all(10), child: currentCard),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton("Change", () {
                          chooseMode(currentMode);
                        }),
                        RoundedButton("Play", () {
                          if (currentPuzzleInfo == null) {
                            annouceHaventChooseDialog();
                          } else {
                            playGame();
                          }
                        })
                      ],
                    ))
              ]),
            )));
  }
}
