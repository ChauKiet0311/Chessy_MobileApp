import "package:chessy/components/create_room_button.dart";
import "package:flutter/material.dart";

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CreateRoomButton("Normal Match", () {
                      print("Normal Matched");
                    }),
                    CreateRoomButton("Blitz Match", () {})
                  ],
                ),
                Row(
                  children: [
                    CreateRoomButton("Blitz 10", () {}),
                    CreateRoomButton("Puzzle", () {})
                  ],
                )
              ],
            ))));
  }
}
