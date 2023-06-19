import 'package:flutter/material.dart';
import 'package:chessy/components/rounded_button_bold.dart';
import '../components/edit_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() {
    return _ChangePasswordScreenState();    
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  
  final userNameTextController = TextEditingController();
  final oldPasswordTextController = TextEditingController();
  final newPasswordTextController = TextEditingController();
  final reEnterPasswordTextController = TextEditingController();

  @override
  void dispose() {
    userNameTextController.dispose(); 
    oldPasswordTextController.dispose();
    newPasswordTextController.dispose();
    reEnterPasswordTextController.dispose();
    super.dispose(); 
  }


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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [   
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text( "CHANGE PASSWORD",
                          style: TextStyle( 
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                      ),
            
                      const SizedBox(height: 30),
            
                      Column(
                        children: [
                          const SizedBox(height: 30),
                          EditTextField("UserName", userNameTextController, hint: 'Type in your user name', icon: Icon(Icons.lock)),
                          const SizedBox(height: 15),
                          EditTextField("Old Password", oldPasswordTextController, hint: 'Type in your old password',icon: Icon(Icons.remove_red_eye_outlined)),
                          const SizedBox(height: 15),
                          EditTextField("New Password", newPasswordTextController, hint: 'Type in your new password',icon: Icon(Icons.remove_red_eye_outlined)),
                          const SizedBox(height: 15),
                          EditTextField("Email", reEnterPasswordTextController,hint: 'Type in your email address', icon: Icon(Icons.remove_red_eye_outlined)),
                        ],
                      ),       
            
                      const SizedBox(height: 100),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: RoundedButtonBold("Back",
                              () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
            
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: RoundedButtonBold("Save",
                              () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
            
                      const SizedBox(height: 80,),
                    ],
                  )
                )
              ),
            )
          ),
        )
      )
    );
  }
}
