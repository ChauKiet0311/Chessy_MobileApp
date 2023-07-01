import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class RoomItemHistory extends StatelessWidget {
  final String roomName;
  final String player;
  final String player2;

  const RoomItemHistory(
      {super.key,
      required this.roomName,
      required this.player,
      required this.player2});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 5,
        child: InkWell(
            child: Container(
          padding: const EdgeInsets.all(10),
          width: 350,
          height: 160,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 105, 14, 91),
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      Image.asset(
                        "image/avatar.png",
                        fit: BoxFit.contain,
                        height: 50,
                        width: 50,
                      ),
                      Text(player,
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Color.fromARGB(255, 233, 226, 234)))
                    ]),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '#$roomName',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Color.fromARGB(255, 233, 226, 234)),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Played against: $player2',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Color.fromARGB(255, 233, 226, 234)),
                          maxLines: 1,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
