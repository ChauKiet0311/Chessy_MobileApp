import "package:flutter/material.dart";

class SettingTabView extends StatefulWidget {
  @override
  State<SettingTabView> createState() {
    return _SettingTabView();
  }
}

class _SettingTabView extends State<SettingTabView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 50,
      ),
      Text(
        "SETTING",
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.white),
      ),
    ]);
  }
}
