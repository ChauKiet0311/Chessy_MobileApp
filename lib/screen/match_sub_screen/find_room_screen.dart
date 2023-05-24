import "package:chessy/components/create_room_button.dart";
import "package:chessy/components/room_item.dart";
import "package:flutter/material.dart";

class FindRoomScreen extends StatefulWidget {
  const FindRoomScreen({super.key});

  @override
  State<FindRoomScreen> createState() => _FindRoomScreen();
}

class _FindRoomScreen extends State<FindRoomScreen> {
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
                      child: Text('Open Room',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: Colors.white
                        ),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),

                  Expanded(child: ListView.builder(
                    itemBuilder: (ctx, index) => Container(
                        child: RoomItem(mode: 'mode', roomName: "roomName", number: "number", player: "player"),
                        margin: const EdgeInsets.all(10),
                      ),
                    itemCount: 3,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ))
                ],
              )
            )
          )
        );
  }
}
