import "dart:convert";
import "dart:io";

import "package:chessy/components/room_item_history.dart";
import "package:chessy/screen/game_screen/history_game_screen.dart";
import "package:flutter/material.dart";
import "package:http/http.dart";

import "../components/rounded_button_bold.dart";
import 'package:chessy/constant.dart' as globals;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: globals.currentUser.refreshToken as String,
    HttpHeaders.accessControlAllowOriginHeader: "*",
    'Accept': '*/*'
  };

  List<dynamic> list_history = [];

  void loadHistory() async {
    String currentUser = globals.currentUser.username as String;

    Response response = await get(
        Uri.https(globals.API, globals.GET_HISTORY_USER + currentUser),
        headers: headers);
    if (response.statusCode == 200) {
      list_history = jsonDecode(response.body);
    }
    setState(() {});
    print(list_history.length);
  }

  @override
  void initState() {
    super.initState();

    loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage('image/167.jpg'),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: const Text(
                              "HISTORY",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: Colors.white),
                            ),
                          ),
                          Expanded(
                              child: list_history.length == 0
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const CircularProgressIndicator(),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    )
                                  : ListView.builder(
                                      itemBuilder: (ctx, index) => Container(
                                        child: RoomItemHistory(
                                          press: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (ctx) =>
                                                    HistoryGameScreen(
                                                  gameHistory:
                                                      list_history[index]
                                                          ['history'],
                                                ),
                                              ),
                                            );
                                          },
                                          roomName: list_history[index]
                                              ['gameID'],
                                          player: list_history[index]
                                                      ['player1'] ==
                                                  globals.currentUser.username
                                                      as String
                                              ? list_history[index]['player1']
                                              : list_history[index]['player2'],
                                          player2: list_history[index]
                                                      ['player1'] ==
                                                  globals.currentUser.username
                                                      as String
                                              ? list_history[index]['player2']
                                              : list_history[index]['player1'],
                                        ),
                                        //RoomItem(mode: 'mode', roomName: "roomName", number: "number", player: "player"),
                                        margin: const EdgeInsets.all(10),
                                      ),
                                      itemCount: list_history.length,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                    )),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: RoundedButtonBold(
                                "Back",
                                () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      )))),
            )));
  }
}
