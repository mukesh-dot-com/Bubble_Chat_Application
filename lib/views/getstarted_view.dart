import 'package:bubble/constants/route.dart';
import 'package:bubble/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({super.key});

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /*Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/FullView.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),*/
          const SizedBox(
            height: 80,
          ),
          SizedBox(
            height: 100,
            child: Stack(
              children: [
                const Positioned(
                  child: Center(
                    child: Text(
                      'B   bble',
                      style: TextStyle(
                        fontSize: 50,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 140,
                  top: 33,
                  child: SizedBox(
                    height: 60,
                    width: 80,
                    child: Lottie.network(
                      'https://assets2.lottiefiles.com/packages/lf20_laqlcaiq.json',
                      repeat: false,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: const Center(
              child: Text(
                'A user-friendly and easy to use Chat Based App for doctors and patients',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 400,
            width: 500,
            child: Lottie.network(
              'https://assets9.lottiefiles.com/packages/lf20_gnh15vxc.json',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 50,
            width: 330,
            margin: const EdgeInsets.only(top: 100),
            child: TextButton(
              onPressed: () {
                print(FirebaseAuth.instance.currentUser?.phoneNumber);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    // side: const BorderSide(
                    //   color: Color.fromARGB(255, 187, 10, 246),
                    //   width: 2,
                    // ),
                  ),
                ),
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 194, 57, 248)),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          /*SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Lottie.network(
              'https://assets4.lottiefiles.com/packages/lf20_yfZAoe.json',
              fit: BoxFit.cover,
            ),
          ),*/
        ],
      ),
    );
  }
}
