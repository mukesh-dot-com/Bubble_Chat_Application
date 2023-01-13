import 'dart:async';
import 'package:bubble/constants/route.dart';
import 'package:bubble/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OTPView extends StatefulWidget {
  const OTPView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  int _counter = 60;
  late Timer _timer;
  // var usernameController = TextEditingController();
  // var phoneController = TextEditingController();
  var otpController = List.generate(6, (index) => TextEditingController());
  _OTPViewState() {
    _startTimer();
  }
  void _startTimer() {
    // _counter = 120;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  var code = "";
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(234, 239, 243, 1),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: Theme.of(context).primaryColor,
      ),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: Image.asset(
                  "assets/image1.png",
                ),
              ),
              const Text(
                "Enter OTP",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
              ),
              // Text(
              //   '$_counter',
              //   style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              // ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: LoginView.verify,
                      smsCode: code,
                    );
                    await auth.signInWithCredential(credential);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      roleRoute,
                      (route) => false,
                    );
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "Invalid OTP",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 10,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
