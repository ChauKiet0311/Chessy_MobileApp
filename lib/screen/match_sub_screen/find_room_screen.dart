import "dart:convert";
import "dart:io";

import "package:chessy/components/create_room_button.dart";
import "package:chessy/components/room_item.dart";
import "package:chessy/screen/match_sub_screen/create_room_sub_screen/waiting_room.dart";
import "package:flutter/material.dart";
import "package:http/http.dart";
import 'package:chessy/constant.dart' as globals;

class FindRoomScreen extends StatefulWidget {
  const FindRoomScreen({super.key});

  @override
  State<FindRoomScreen> createState() => _FindRoomScreen();
}

class _FindRoomScreen extends State<FindRoomScreen> {
  bool isLoaded = false;

  List<dynamic> list_rooms = [];

  void loadGames() async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          globals.currentUser.refreshToken as String,
      HttpHeaders.accessControlAllowOriginHeader: "*",
      'Accept': '*/*'
    };

    Response response = await get(Uri.https(globals.API, globals.GET_ROOM_API),
        headers: headers);
    if (response.statusCode == 200) {
      list_rooms = jsonDecode(response.body);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    loadGames();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(
                      'Open Room',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: Colors.white),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (ctx, index) => Container(
                    child: RoomItem(
                        press: () async {
                          String gameId = list_rooms[index]['gameId'];
                          String currentUsername =
                              globals.currentUser.username as String;
                          //Call HTTP request to connect to the game

                          Map<String, String> headers = {
                            HttpHeaders.contentTypeHeader: "application/json",
                            HttpHeaders.authorizationHeader:
                                globals.currentUser.refreshToken as String
                          };

                          String json_post =
                              '{"player":"$currentUsername","gameId":"$gameId"}';

                          Response connectGame = await post(
                            Uri.https(globals.API, globals.CONNECT_API),
                            headers: headers,
                            body: json_post,
                          );

                          print(connectGame.statusCode);

                          if (connectGame.statusCode == 200) {
                            json_post =
                                '{"player2":"$currentUsername","gameID":"$gameId","message": "CONNECTING"}';
                            Response annouceHost = await post(
                              Uri.https(globals.API, globals.GAMEPLAY_API),
                              headers: headers,
                              body: json_post,
                            );

                            Map<String, dynamic> map =
                                jsonDecode(connectGame.body);

                            if (annouceHost.statusCode == 200) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WaitingScreen(
                                            roomName: map['roomName'],
                                            secondsPerMove: map['secsPerMoves'],
                                            timeStop: map['timeAllowStop'],
                                            userName: globals.currentUser
                                                .getUsername as String,
                                            gameInfo: map,
                                          )));
                            }
                          }
                        },
                        mode: list_rooms[index]['status'],
                        roomName: list_rooms[index]['roomName'],
                        number: "1",
                        player: list_rooms[index]['player1']),
                    margin: const EdgeInsets.all(10),
                  ),
                  itemCount: list_rooms.length,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ))
              ],
            ))));
  }
}
