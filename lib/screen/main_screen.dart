import 'package:chessy/screen/learning_main_screen.dart';
import 'package:chessy/screen/setting_main_screen.dart';
import 'package:flutter/material.dart';
import 'match_main_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:chessy/components/navigation_bar_icon_icons.dart';

class MainScreen extends StatefulWidget {
  //jwt token will be passed here!
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State<MainScreen> {
  int currentViewIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _viewOptions = <Widget>[
      LearningTabView(),
      MatchTabView(),
      SettingTabView()
    ];
    return Scaffold(
      appBar: AppBar(title: Text("Chessy")),
      body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: const AssetImage(
                      'image/167.jpg'), //File ảnh background là image/167.jpg
                  fit: BoxFit.cover)),
          child: _viewOptions.elementAt(currentViewIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(1))
        ]),
        child: GNav(
          backgroundColor: const Color.fromARGB(255, 129, 31, 134),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Color.fromARGB(255, 227, 151, 231),
          gap: 8,
          padding: EdgeInsets.all(16),
          tabs: const [
            GButton(icon: NavigationBarIcon.learning, text: 'Learning'),
            GButton(icon: NavigationBarIcon.matching, text: 'Matching'),
            GButton(icon: NavigationBarIcon.setting, text: 'Setting')
          ],
          selectedIndex: currentViewIndex,
          onTabChange: (index) {
            setState(() {
              currentViewIndex = index;
            });
          },
        ),
      ),
    );
  }
}
