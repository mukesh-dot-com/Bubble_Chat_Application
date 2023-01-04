import 'dart:async';
import 'package:bubble/views/login_view.dart';
import 'package:flutter/material.dart';

// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
// OTPTextField(
// length: 5,
// width: MediaQuery.of(context).size.width,
// fieldWidth: 80,
// style: TextStyle(
// fontSize: 17
// ),
// textFieldAlignment: MainAxisAlignment.spaceAround,
// fieldStyle: FieldStyle.underline,
// onCompleted: (pin) {
// print("Completed: " + pin);
// },
// ),
class OTPView extends StatefulWidget {
  const OTPView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Page'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    6,
                    (index) => SizedBox(
                          width: 56,
                          child: TextField(
                            // controller: controller.otpController[index],
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            onChanged: (value) {
                              if (value.length == 1 && index <= 5) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            style: const TextStyle(),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                hintText: "*"),
                          ),
                        )),
              ),
            ),
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       _startTimer();
            //     },
            //     child: Text('Start')),
            // _startTimer();
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _timer.cancel();
                    _startTimer();
                    _counter = 120;
                  });
                },
                child: const Text('Resend')),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginView(),
                  ),
                );
              },
              child: const Text(
                'Verify',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
