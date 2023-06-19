import "package:chessy/components/rounded_button_bold.dart";
import "package:chessy/screen/system_setting/security_policy_screen.dart";
import "package:chessy/screen/system_setting/terms_screen.dart";
import "package:flutter/material.dart";

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('image/167.jpg'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [   
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text( "ABOUT US",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: InkWell(
                          child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 249, 216, 244),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Chessy',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color:
                                      Color.fromARGB(255, 129, 31, 134)),
                            ),
                            Text(
                              ': ©2023 Chessy',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                  //fontFamily: 'Montserrat',
                                  //fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color:
                                      Color.fromARGB(255, 129, 31, 134)),
                            ),
                          ],
                        )
                    ))),

                    const SizedBox(height: 30),

                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: InkWell(
                          child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 249, 216, 244),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Version',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color:
                                      Color.fromARGB(255, 129, 31, 134)),
                            ),
                            Text(
                              ': 1.0 (Latest Version)',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                  //fontFamily: 'Montserrat',
                                  //fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color:
                                      Color.fromARGB(255, 129, 31, 134)),
                            ),
                          ],
                        )
                    ))),

                    const SizedBox(height: 30),

                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: InkWell(
                          child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 15),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 145,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 249, 216, 244),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Team members:',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color:
                                      Color.fromARGB(255, 129, 31, 134)),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '   • Lê Quang Minh',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color:
                                          Color.fromARGB(255, 129, 31, 134)),
                                ),
                                Text(
                                  '   • Châu Kiệt',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color:
                                          Color.fromARGB(255, 129, 31, 134)),
                                ),
                                Text(
                                  '   • Cao Chánh Khải',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color:
                                          Color.fromARGB(255, 129, 31, 134)),
                                ),
                              ],
                            ),
                          ],
                        )
                    ))),

                    const SizedBox(height: 40),

                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: RoundedButtonBold(
                        "Security Policy",
                        () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (ctx) => SecurityPolicyScreen(),
                          ),);
                        },
                      ),
                    ),

                    const SizedBox(height: 30),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: RoundedButtonBold(
                        "Terms of use",
                        () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (ctx) => TermsScreen(),
                          ),);
                        },
                      ),
                    ),

                    const SizedBox(height: 55),                    

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
