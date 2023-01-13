import 'package:bubble/constants/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String verify = "";
  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String phone = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset("assets/image3.png"),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 20.0,
              ),
              child: Center(
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: Text(
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: SizedBox(
                width: 300,
                height: 50,
                child: Text(
                  "Enter Your Phone Number Here",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 10,
                bottom: 10,
              ),
              // padding: EdgeInsets.symmetric(horizontal: 15,),
              child: TextField(
                onChanged: (value) {
                  phone = value;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  // fillColor: Colors.purpleAccent,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 2,
                    color: Colors.deepPurpleAccent,
                  )),
                  labelText: 'Phone number',
                  hintText: 'Enter Phone number',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                maxLength: 10,
              ),
            ),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: MaterialButton(
                onPressed: () async {
                  if (phone.length != 10) {
                    Fluttertoast.showToast(
                      msg: "Phone Number Must Be 10 Digits",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 10,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    print(phone);
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '${"+91" + phone}',
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        LoginView.verify = verificationId;
                        Navigator.of(context).pushNamed(otpRoute);
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  }
                },
                child: const Text(
                  'Get OTP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
