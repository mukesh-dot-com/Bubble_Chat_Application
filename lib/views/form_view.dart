import 'package:bubble/constants/route.dart';
import 'package:bubble/views/explore_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class FormView extends StatefulWidget {
  String? role;
  FormView({super.key, required this.role});

  @override
  // ignore: library_private_types_in_public_api
  _FormViewState createState() => _FormViewState(role);
}

class _FormViewState extends State<FormView> {
  final user = FirebaseAuth.instance.currentUser;
  String bloodName = "";
  List bloodType = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String? role;
  _FormViewState(this.role);
  @override
  void initState() {
    super.initState();
    print(role);
    dateController.text = "";
  }

  var name = "";

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
                    )),
                maxLength: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: TextField(
                controller: dateController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.calendar_today),
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
                  labelText: 'Date',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat("yyyy-MM-dd").format(pickedDate);

                    setState(
                      () {
                        dateController.text = formattedDate.toString();
                      },
                    );
                  } else {
                    print("Not selected");
                  }
                },
              )),
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
                  prefixIcon: const Icon(Icons.email_rounded),
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
                  labelText: 'Email ID',
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
                controller: bloodController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.height),
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
                  labelText: 'Blood Type',
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
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.height),
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
                  labelText: 'Enter your height (ft)',
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
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.scale),
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
                    labelText: 'Enter your weight (kgs)',
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
                onPressed: () {
                  if (nameController.text == "") {
                    return showError("User Name");
                  } else if (dateController.text == "") {
                    return showError("Date Field");
                  } else if (bloodController.text == "") {
                    return showError("Blood Type Field");
                  } else if (emailController.text == "") {
                    return showError("Email Field");
                  } else if (heightController.text == "") {
                    return showError("Height Field");
                  } else if (weightController.text == "") {
                    return showError("Weight Field");
                  } else {
                    Map<String, dynamic> patientData = {
                      "name": nameController.text,
                      "dob": dateController.text,
                      "blood_type": bloodController.text,
                      "email": emailController.text,
                      "height": heightController.text,
                      "weight": weightController.text,
                      "image": null,
                      "phone": user?.phoneNumber,
                    };
                    print(patientData);
                    try {
                      FirebaseFirestore.instance
                          .collection("patient")
                          .doc(user?.phoneNumber)
                          .set(patientData)
                          .whenComplete(() => {print("success")});
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ExploreView(role: role),
                        ),
                      );
                    } catch (e) {
                      print("failure");
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
