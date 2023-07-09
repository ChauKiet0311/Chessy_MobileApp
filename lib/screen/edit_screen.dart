import 'package:flutter/material.dart';
import 'package:chessy/components/rounded_button_bold.dart';
import '../components/edit_textfield.dart';
import 'package:chessy/constant.dart' as globals;

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() {
    return _EditScreenState();
  }
}

class _EditScreenState extends State<EditScreen> {
  final userNameTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();

  @override
  void dispose() {
    userNameTextController.dispose();
    nameTextController.dispose();
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: true,
        body: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('image/167.jpg'), fit: BoxFit.cover)),
            child: SafeArea(
              child: Center(
                  child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "EDIT PROFILE",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 30),
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: Image.network(
                            globals.avatarURL,
                          ).image,
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 30),
                            EditTextField("UserName", userNameTextController,
                                hint: 'Type in your user name',
                                icon: const Icon(Icons.lock)),
                            const SizedBox(height: 15),
                            EditTextField("Name", nameTextController,
                                hint: 'Type in your name',
                                icon: const Icon(Icons.abc)),
                            const SizedBox(height: 15),
                            EditTextField("Email", emailTextController,
                                hint: 'Type in your email address',
                                icon: const Icon(Icons.abc)),
                          ],
                        ),
                        const SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: RoundedButtonBold(
                                "Back",
                                () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: RoundedButtonBold(
                                "Save",
                                () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                      ],
                    ))),
              )),
            )));
  }
}
