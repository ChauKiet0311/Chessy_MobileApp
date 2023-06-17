import "package:flutter/material.dart";
import "../components/rounded_button_bold.dart";

class SystemSettingScreen extends StatefulWidget {
  const SystemSettingScreen({super.key});

  @override
  State<SystemSettingScreen> createState() => _SystemSettingScreen();
}

class _SystemSettingScreen extends State<SystemSettingScreen> {
  @override
  Widget build(BuildContext context) {
    double sound = 50;
    double music = 40;

    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('image/167.jpg'), fit: BoxFit.cover)),
          child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          "SYSTEM SETTING",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                          child: InkWell(
                              child: Container(
                            padding: const EdgeInsets.all(30),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 230,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 249, 216, 244),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Sound',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 129, 31, 134)),
                                  ),
                                  StatefulBuilder(
                                    builder: (context, setState) {
                                      return Slider(
                                        value: sound,
                                        onChanged: (value) {
                                          setState(() {
                                            sound = value;
                                          });
                                        },
                                        label: sound.round().toString(),
                                        min: 0,
                                        max: 100,
                                        divisions: 100,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 25),
                                  const Text(
                                    'Music',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 129, 31, 134)),
                                  ),
                                  StatefulBuilder(
                                    builder: (context, setState) {
                                      return Slider(
                                        value: music,
                                        onChanged: (value) {
                                          setState(() {
                                            music = value;
                                          });
                                        },
                                        label: music.round().toString(),
                                        min: 0,
                                        max: 100,
                                        divisions: 100,
                                      );
                                    },
                                  ),
                                ]),
                          ))),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: RoundedButtonBold(
                          "Tutorial",
                          () {},
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: RoundedButtonBold(
                          "About Us",
                          () {},
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: RoundedButtonBold(
                          "Back",
                          () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  )))),
    );
  }
}
