import "package:chessy/components/rounded_button_bold.dart";
import "package:flutter/material.dart";

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
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
                      child: Text( "TERMS OF USE",
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
                        padding: const EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.6,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 249, 216, 244),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Text(
                          'llllllllllllll',
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                              //fontFamily: 'Montserrat',
                              //fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color:
                                  Color.fromARGB(255, 129, 31, 134)),
                        )
                    ))),

                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.6,
                    //   width: MediaQuery.of(context).size.width * 0.9,
                    //   child: RoundedButtonBold(
                    //     "About Us",
                    //     () {
                          
                    //     },
                    //   ),
                    // ),

                    const SizedBox(height: 45),                    

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
