import 'package:flutter/material.dart';
import 'package:chessy/components/rounded_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() {
    return _OtpVerificationScreenState();
  }
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> otpTextControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  int remainingTime = 5; // 5 minutes in seconds
  bool canResend = false;

  void startTimer() {
    Future<void>.delayed(const Duration(seconds: 1), () {
      setState(() {
        remainingTime--;
        if (remainingTime == 0) {
          canResend = true;
        }
      });
      if (remainingTime > 0) {
        startTimer();
      }
    });
  }

  String formatTime(int time) {
    final minutes = (time ~/ 60).toString().padLeft(2, '0');
    final seconds = (time % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    for (var controller in otpTextControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("OTP Verification"),
      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/167.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Verification code",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "We have sent the code verification to:",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget
                    .email, // Sử dụng thuộc tính email để hiển thị email của người dùng đã đăng ký
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var index = 0; index < 6; index++)
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: otpTextControllers[index],
                        focusNode: focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (index < 5) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index + 1]);
                            } else {
                              // Do something when the last digit is entered
                            }
                          } else {
                            if (index > 0) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index - 1]);
                            }
                          }
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              canResend
                  ? RoundedButton(
                      "Resend",
                      () {
                        // Do something when the Resend button is pressed
                      },
                    )
                  : Text(
                      "Resend code after ${formatTime(remainingTime)}",
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
              const SizedBox(height: 10),
              RoundedButton(
                "Submit",
                () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
