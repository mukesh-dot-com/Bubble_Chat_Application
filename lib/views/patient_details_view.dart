import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientDetailsView extends StatefulWidget {
  String phone;
  PatientDetailsView(this.phone, {super.key});

  @override
  State<PatientDetailsView> createState() => _PatientDetailsViewState(phone);
}

class _PatientDetailsViewState extends State<PatientDetailsView> {
  String? phone;
  _PatientDetailsViewState(this.phone);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("patient")
          .doc(phone)
          .get()
          .asStream(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.data != null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 1,
              title: const Text(
                "Edit Profile",
              ),
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back, color: Colors.black),
              //   onPressed: () {
              //     // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     //     builder: (BuildContext context) => const SettingView()));
              //   },
              // ),
            ),
            body: Container(
              padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              // boxShadow: [
                              //   BoxShadow(
                              //       spreadRadius: 2,
                              //       blurRadius: 10,
                              //       color: Colors.black.withOpacity(0.1),
                              //       offset: const Offset(0, 10))
                              // ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: (snapshot.data?["image"] == null)
                                    ? const NetworkImage(
                                        "https://th.bing.com/th/id/R.5ab3c6cef7371558452991283427f99a?rik=spJHOzCaiPrxRg&riu=http%3a%2f%2fwww.citylifecarehospital.com%2fcm-admin%2fuploads%2fimage%2f2131-10-doctor-icon-iconbunny.jpg&ehk=d4f4z7ssE4CYT3GFzcECCiy0hXItS3SqZdW5wkadXQ8%3d&risl=&pid=ImgRaw&r=0")
                                    : NetworkImage(snapshot.data?["image"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Full Name",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            Text(
                              snapshot.data!["name"],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),

                        Row(
                          children: [
                            const Text(
                              "Blood Type        ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            Text(
                              snapshot.data!["blood_type"],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ), //dob not coming properly
                        const SizedBox(
                          height: 40,
                        ),

                        // Padding(
                        //   padding: EdgeInsets.only(bottom: 35.0),
                        //   child: TextField(
                        //     controller: dateController,
                        //     // keyboardType: TextInputType.text,
                        //     decoration: InputDecoration(
                        //         contentPadding: EdgeInsets.only(bottom: 3),
                        //         labelText: "DOB",
                        //         floatingLabelBehavior: FloatingLabelBehavior.always,
                        //         hintText: snapshot.data?["dob"],
                        //         hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,)),
                        //   ),
                        // ),

                        Row(
                          children: [
                            const Text(
                              "Height             ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            Text(
                              snapshot.data!["height"] + "ft",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Weight            ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            Text(
                              snapshot.data!["weight"] + "Kg",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            const Text(
                              "DOB            ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            Text(
                              snapshot.data!["dob"],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 80,
                            ),
                            Text(
                              snapshot.data!["email"],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
