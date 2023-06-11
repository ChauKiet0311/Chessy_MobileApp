import "package:chessy/screen/match_sub_screen/find_room_screen.dart";
import "package:flutter/material.dart";
import "package:chessy/screen/match_sub_screen/create_room_screen.dart";

class MatchTabView extends StatefulWidget {
  const MatchTabView({super.key});

  @override
  State<MatchTabView> createState() {
    return _MatchTabView();
  }
}

class _MatchTabView extends State<MatchTabView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Column(children: [
      const SizedBox(
        height: 50,
      ),
      const Text(
        "MATCH",
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.white),
      ),
      const SizedBox(height: 5),
      Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(200, 220, 197, 212),
                borderRadius: BorderRadius.circular(17)),
            child: TabBar(
              indicator: BoxDecoration(
                  color: const Color.fromARGB(100, 204, 165, 206),
                  borderRadius: BorderRadius.circular(17)),
              controller: tabController,
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 20),
              tabs: const [
                Tab(child: Text("Create room", style: TextStyle(fontSize: 12))),
                Tab(
                    child: Text(
                  "Find room",
                  style: TextStyle(fontSize: 12),
                ))
              ],
            ),
          )),
      Expanded(
          child: TabBarView(controller: tabController, children: const [
        CreateRoomScreen(),
        FindRoomScreen(),
      ]))
    ]);
  }
}
