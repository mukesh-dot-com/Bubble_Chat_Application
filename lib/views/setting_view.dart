import 'dart:io';

import 'package:bubble/views/footer_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  String imageURL = "";
  final user = FirebaseFirestore.instance;
  String imageMainURL = "";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("patient")
            .doc("xWmIL6IgNVSWxXxrdDEQ")
            .get()
            .asStream(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Stack(children: [
                  Center(
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        backgroundImage: (snapshot.data!["image"] != null)
                            ? NetworkImage(snapshot.data!["image"])
                            : const NetworkImage("assets/doctor.jpg"),
                        minRadius: 1,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 230,
                    top: 110,
                    child: IconButton(
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        print('${file?.path}');
                        if (file == null) return;
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');
                        Reference refImage =
                            referenceDirImages.child(uniqueFileName);

                        try {
                          //Store File
                          await refImage.putFile(File(file.path));
                          imageURL = await refImage.getDownloadURL();
                          await user
                              .collection("patient")
                              .doc("xWmIL6IgNVSWxXxrdDEQ")
                              .update({"image": imageURL});
                        } catch (e) {
                          //Error Will go here.
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 34,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Dr. Sandeep",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const Text(
                  "MBBS, KIMS",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 130,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 45, right: 45),
                  child: ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Theme.of(context).primaryColor,
                      size: 25,
                    ),
                    title: const Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 45, right: 45),
                  child: ListTile(
                    leading: Icon(
                      Icons.info_outline_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 25,
                    ),
                    title: const Text(
                      "App Information",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 45, right: 45),
                  child: ListTile(
                    leading: Icon(
                      Icons.logout_sharp,
                      color: Theme.of(context).primaryColor,
                      size: 25,
                    ),
                    title: const Text(
                      "Sign Out",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 45, right: 45),
                  child: ListTile(
                    leading: Icon(
                      Icons.delete_forever,
                      color: Theme.of(context).primaryColor,
                      size: 25,
                    ),
                    title: const Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: const FooterView(3),
          );
        });
  }
}
