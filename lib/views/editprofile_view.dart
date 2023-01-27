import 'package:bubble/constants/route.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickalert/quickalert.dart';

class EditProfileView extends StatefulWidget {
  String? role;
  EditProfileView(this.role, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileViewState createState() => _EditProfileViewState(role);
}

class _EditProfileViewState extends State<EditProfileView> {
  final user = FirebaseAuth.instance.currentUser;

  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String? role;
  _EditProfileViewState(this.role);

  @override
  void initState() {
    super.initState();
    print(role);
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("patient")
            .doc(user?.phoneNumber)
            .get()
            .asStream(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 10))
                              ],
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
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Colors.purpleAccent,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: TextField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: "Full Name",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: snapshot.data?["name"],
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: "Email",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: snapshot.data?["email"],
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: "DOB",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: snapshot.data?["dob"],
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
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
                      ),
                    ), //dob not coming properly

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

                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: TextField(
                        controller: bloodController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: "Blood Group",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: snapshot.data?["blood_type"],
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: TextField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: "Height",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: snapshot.data?["height"],
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: "Weight",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: snapshot.data?["weight"],
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                settingRoute, (route) => false);
                          },
                          child: const Text("CANCEL",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Map<String, dynamic> patientData = {
                              "phone": user?.phoneNumber,
                              "name": (nameController.text == "")
                                  ? (snapshot.data?["name"])
                                  : nameController.text,
                              "dob": (dateController.text == "")
                                  ? (snapshot.data?["dob"])
                                  : dateController.text,
                              "blood_type": (bloodController.text == "")
                                  ? (snapshot.data?["blood_type"])
                                  : bloodController.text,
                              "email": (emailController.text == "")
                                  ? (snapshot.data?["email"])
                                  : emailController.text,
                              "height": (heightController.text == "")
                                  ? (snapshot.data?["height"])
                                  : heightController.text,
                              "weight": (weightController.text == "")
                                  ? (snapshot.data?["weight"])
                                  : weightController.text,
                            };
                            print(patientData);
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              confirmBtnText: "Yes",
                              cancelBtnText: "No",
                              confirmBtnColor: Colors.purple,
                              text:
                                  "Are you sure that you want to overwrite the above changes",
                              onConfirmBtnTap: () {
                                FirebaseFirestore.instance
                                    .collection("patient")
                                    .doc(user?.phoneNumber)
                                    .update(patientData)
                                    .whenComplete(
                                      () => {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          confirmBtnColor: Colors.purple,
                                        )
                                      },
                                    );
                              },
                            );
                          },
                          child: const Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  // Widget buildTextField(String labelText, String placeholder) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 35.0),
  //     child: TextField(
  //       keyboardType: TextInputType.text,
  //       decoration: InputDecoration(
  //           contentPadding: EdgeInsets.only(bottom: 3),
  //           labelText: labelText,
  //           floatingLabelBehavior: FloatingLabelBehavior.always,
  //           hintText: placeholder,
  //           hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,)),
  //     ),
  //   );
  // }
}
