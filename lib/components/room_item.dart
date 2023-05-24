import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  final String mode;
  final String roomName;
  final String number;
  final String player;

  const RoomItem({super.key, required this.mode, required this.roomName, required this.number, required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 5,
        child: new InkWell(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 350,
              height: 110,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 105, 14, 91),
                borderRadius: BorderRadius.all(Radius.circular(18))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset( "image/avatar.png",
                          fit: BoxFit.contain,
                          height: 50,
                          width: 50,
                        ),

                        Text(player,
                          style: TextStyle(
                                fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Color.fromARGB(255, 233, 226, 234)
                          )
                        )
                    ]),

                    SizedBox(width: 30,),
              
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Room name: ${roomName}',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Color.fromARGB(255, 233, 226, 234)
                            ),
                            maxLines: 1,
                        ),
                        SizedBox(height: 7),
                        Text('#${number}',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Color.fromARGB(255, 233, 226, 234)
                            ),
                            maxLines: 1,
                        ),
                        SizedBox(height: 7),
                        Text('Mode: ${number}',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Color.fromARGB(255, 233, 226, 234)
                            ),
                            maxLines: 1,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
