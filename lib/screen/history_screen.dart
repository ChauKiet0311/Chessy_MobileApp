import "package:chessy/components/room_item_history.dart";
import "package:flutter/material.dart";

import "../components/rounded_button_bold.dart";

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
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
                      child: const Text( "SETTING",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),
        
                    Expanded(child: ListView.builder(
                      itemBuilder: (ctx, index) => Container(
                          child: RoomItemHistory(
                            date: DateTime.now(),
                            mode: 'mode', 
                            roomName: "roomName", 
                            number: "number", 
                            player: "player",
                            result: 'Lose',
                          ),
                          //RoomItem(mode: 'mode', roomName: "roomName", number: "number", player: "player"),
                          margin: const EdgeInsets.all(10),
                        ),
                      itemCount: 3,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    )),

                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: RoundedButtonBold("Back",
                        () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),

                    const SizedBox(height: 80,),
                  ],
                )
              )
            )
          ),
        )
      )
    );
  }
}
