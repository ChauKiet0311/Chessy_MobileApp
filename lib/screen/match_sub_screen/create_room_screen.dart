import "package:chessy/components/create_room_button.dart";
import "package:chessy/models/puzzleInfo.dart";
import "package:chessy/screen/match_sub_screen/create_room_sub_screen/create_room_normal_room.dart";
import "package:chessy/screen/match_sub_screen/create_room_sub_screen/puzzle_screen.dart";
import "package:flutter/material.dart";
import 'package:material_dialogs/material_dialogs.dart';
import "package:material_dialogs/widgets/buttons/icon_outline_button.dart";

class CreateRoomScreen extends StatelessWidget {
  CreateRoomScreen({super.key});
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateNormalRoomScreen(
                                  mode: "Normal Match")));
                    }),
                    CreateRoomButton("Blitz Match", () {})
                  ],
                ),
                Row(
                  children: [
                    CreateRoomButton("Blitz 10", () {}),
                    CreateRoomButton(
                        "Puzzle",
                        () => Dialogs.materialDialog(
                                context: context,
                                msg:
                                    ("Are you sure you want to choose this mode?"),
                                actions: [
                                  IconsOutlineButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PuzzleScreen()));
                                    },
                                    text: "Yes",
                                    iconData: Icons.check,
                                  ),
                                  IconsOutlineButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(context);
                                      },
                                      text: "No",
                                      iconData: Icons.close)
                                ]))
                  ],
                )
              ],
            ))));
  }
}
