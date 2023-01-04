import 'package:bubble/views/otp_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: Image.asset('assets/newlogo.jpg'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 20,
                bottom: 10,
              ),
              // padding: EdgeInsets.symmetric(horizontal: 15,),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  labelText: 'Phone number',
                  hintText: 'Enter Phone number',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                maxLength: 10,
              ),
            ),

            // MaterialButton(
            // onPressed: () {
            //TODO FORGOT PASSWORD SCREEN GOES HERE
            // },
            // child: Text(
            //   'New User? Create Account',
            //   style: TextStyle(color: Colors.black, fontSize: 15),
            // ),
            // ),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const OTPView()));
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
