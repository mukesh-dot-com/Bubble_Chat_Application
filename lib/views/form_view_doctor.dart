import 'package:bubble/constants/route.dart';
import 'package:bubble/views/explore_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class FormDoctorView extends StatefulWidget {
  String? role;
  FormDoctorView({super.key, required this.role});

  @override
  // ignore: library_private_types_in_public_api
  _FormDoctorViewState createState() => _FormDoctorViewState(role);
}

class _FormDoctorViewState extends State<FormDoctorView> {
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController specialController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  var name = "";
  String? role;
  _FormDoctorViewState(this.role);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 70,
            ),
            const Text(
              "Enter Your Data",
              style: TextStyle(
                fontSize: 35,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 20,
                bottom: 0,
              ),
              // padding: EdgeInsets.symmetric(horizontal: 15,),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  labelText: 'Enter your full name',
                  hintText: 'Name',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                maxLength: 30,
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
                controller: specialController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.work_rounded),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  labelText: 'Specialization',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
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
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  labelText: 'Email Id',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
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
                controller: aboutController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.add_box),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    labelText: 'About you',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    )),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 40,
                bottom: 10,
              ),
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: MaterialButton(
                onPressed: () async {
                  if (nameController.text == "") {
                    return showError("User Name");
                  } else if (specialController.text == "") {
                    return showError("Specialization Field");
                  } else if (emailController.text == "") {
                    return showError("Email Field");
                  } else if (aboutController.text == "") {
                    return showError("About You Field");
                  } else {
                    Map<String, dynamic> doctorData = {
                      "name": nameController.text,
                      "specialisation": specialController.text,
                      "email": emailController.text,
                      "about": aboutController.text,
                      "image": null,
                      "phone": user?.phoneNumber,
                    };
                    // print(doctorData);
                    try {
                      await FirebaseFirestore.instance
                          .collection("doctor")
                          .doc(user?.phoneNumber)
                          .set(doctorData)
                          .whenComplete(() => {print("success")});
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ExploreView(role: role)));
                    } catch (e) {
                      print("Failure Try Again");
                    }
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showError(String message) {
  Fluttertoast.showToast(
    msg: "$message Should not be empty",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 10,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
