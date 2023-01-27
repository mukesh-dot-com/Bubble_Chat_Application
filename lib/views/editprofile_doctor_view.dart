import 'package:bubble/constants/route.dart';
import 'package:bubble/views/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileDoctorView extends StatefulWidget {
  String? role;
  EditProfileDoctorView(this.role, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileDoctorViewState createState() =>
      _EditProfileDoctorViewState(role);
}

class _EditProfileDoctorViewState extends State<EditProfileDoctorView> {
  final user = FirebaseAuth.instance.currentUser;

  TextEditingController nameController = TextEditingController();
  TextEditingController specialController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  String? role;
  _EditProfileDoctorViewState(this.role);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(role);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("doctor")
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
                        controller: specialController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: "About",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: snapshot.data?["about"],
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
                        controller: specialController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: "Specialisation",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: snapshot.data?["specialisation"],
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
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => SettingView(role)));
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
                              "email": (emailController.text == "")
                                  ? (snapshot.data?["email"])
                                  : emailController.text,
                              "height": (specialController.text == "")
                                  ? (snapshot.data?["height"])
                                  : specialController.text,
                              "weight": (aboutController.text == "")
                                  ? (snapshot.data?["weight"])
                                  : aboutController.text,
                            };
                            print(patientData);
                            FirebaseFirestore.instance
                                .collection("doctor")
                                .doc(user?.phoneNumber)
                                .set(patientData)
                                .whenComplete(() => {print("success")});
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
}
