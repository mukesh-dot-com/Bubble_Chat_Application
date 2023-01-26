import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class DummyChatUserInterfaceView extends StatefulWidget {
  AsyncSnapshot<Object>? snapshot;
  String? role;
  DummyChatUserInterfaceView(this.snapshot, this.role, {Key? key})
      : super(key: key);
  @override
  State<DummyChatUserInterfaceView> createState() =>
      // ignore: no_logic_in_create_state
      _DummyChatUserInterfaceViewState(snapshot, role);
}

class _DummyChatUserInterfaceViewState
    extends State<DummyChatUserInterfaceView> {
  TextEditingController message = TextEditingController();
  AsyncSnapshot? snapshot;
  String? role;
  _DummyChatUserInterfaceViewState(this.snapshot, this.role) {
    print(snapshot?.data['name']);
  }
  String? imageURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        snapshot?.data['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Last Chatted 12/12/2022",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.search),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              child: StreamBuilder(
                stream: (role == "patient")
                    ? FirebaseFirestore.instance
                        .collection("messages")
                        .doc(
                            "${FirebaseAuth.instance.currentUser?.phoneNumber}?${snapshot?.data['phone']}")
                        .collection("messagelist")
                        .orderBy('time')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection("messages")
                        .doc(
                            "${snapshot?.data['phone']}?${FirebaseAuth.instance.currentUser?.phoneNumber}")
                        .collection("messagelist")
                        .orderBy('time')
                        .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("something is wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return (snapshot.data!.docs.isEmpty)
                      ? const Scaffold()
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          primary: true,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot qs =
                                snapshot.data!.docs[index];
                            Timestamp t = qs['time'];
                            DateTime d = t.toDate();
                            return Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Column(
                                crossAxisAlignment: (qs['sender'] ==
                                        FirebaseAuth
                                            .instance.currentUser?.phoneNumber)
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 10,
                                      left: 10,
                                    ),
                                    constraints: BoxConstraints(
                                        minHeight: 50,
                                        minWidth: 120,
                                        maxHeight: double.infinity,
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.75),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      color: (qs['sender'] ==
                                              FirebaseAuth.instance.currentUser
                                                  ?.phoneNumber)
                                          ? Colors.purple
                                          : Colors.indigo,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              child: (qs['image'] == null)
                                                  ? Text(
                                                      qs['message'],
                                                      softWrap: true,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : Image.network(
                                                      qs['image'],
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        (qs['image'] == null)
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 20,
                                                  right: 5,
                                                  left: 5,
                                                ),
                                                child: Text(
                                                  "${d.hour}:${d.minute}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            : const Text(""),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 245, 227, 254),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "This shows the previous chat histtory with your doctor, and you can't chat now.",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            // child: Row(
            //   children: [
            //     // const SizedBox(
            //     //   height: 100,
            //     // ),
            //     Container(
            //       height: 45,
            //       width: 45,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(30),
            //         color: Theme.of(context).primaryColor,
            //       ),
            //       child: IconButton(
            //         onPressed: () async {
            //           ImagePicker imagePicker = ImagePicker();
            //           XFile? file = await imagePicker.pickImage(
            //               source: ImageSource.gallery);
            //           print('${file?.path}');
            //           if (file == null) return;
            //           String uniqueFileName =
            //               DateTime.now().millisecondsSinceEpoch.toString();

            //           Reference referenceRoot =
            //               FirebaseStorage.instance.ref();
            //           Reference referenceDirImages =
            //               referenceRoot.child('images');
            //           Reference refImage =
            //               referenceDirImages.child(uniqueFileName);

            //           try {
            //             //Store File
            //             await refImage.putFile(File(file.path));
            //             imageURL = await refImage.getDownloadURL();
            //             if (role == 'patient') {
            //               await FirebaseFirestore.instance
            //                   .collection("messages")
            //                   .doc(
            //                       "${FirebaseAuth.instance.currentUser?.phoneNumber}?${snapshot?.data['phone']}")
            //                   .collection("messagelist")
            //                   .add(
            //                 {
            //                   'message': null,
            //                   'image': imageURL,
            //                   'sender': FirebaseAuth
            //                       .instance.currentUser?.phoneNumber,
            //                   'receiver': snapshot?.data['phone'],
            //                   'time': DateTime.now(),
            //                 },
            //               );
            //             } else {
            //               if (role == 'doctor') {
            //                 FirebaseFirestore.instance
            //                     .collection("messages")
            //                     .doc(
            //                         "${snapshot?.data['phone']}?${FirebaseAuth.instance.currentUser?.phoneNumber}")
            //                     .collection("messagelist")
            //                     .add(
            //                   {
            //                     'message': message.text,
            //                     'image': null,
            //                     'sender': FirebaseAuth
            //                         .instance.currentUser?.phoneNumber,
            //                     'receiver': snapshot?.data['phone'],
            //                     'time': DateTime.now(),
            //                   },
            //                 );
            //                 message.clear();
            //               }
            //             }
            //             message.clear();
            //           } catch (e) {
            //             //Error Will go here.
            //           }
            //         },
            //         icon: const Icon(
            //           Icons.add,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: TextFormField(
            //         controller: message,
            //         decoration: InputDecoration(
            //           hintText: 'Enter your message here..',
            //           hintStyle: const TextStyle(
            //             color: Color.fromARGB(255, 54, 54, 54),
            //           ),
            //           enabled: true,
            //           contentPadding:
            //               const EdgeInsets.only(left: 14.0, top: 8.0),
            //           enabledBorder: UnderlineInputBorder(
            //             borderSide:
            //                 const BorderSide(color: Colors.transparent),
            //             borderRadius: BorderRadius.circular(30),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderSide: const BorderSide(color: Colors.purple),
            //             borderRadius: BorderRadius.circular(30),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 50,
            //       width: 50,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(30),
            //         color: Theme.of(context).primaryColor,
            //       ),
            //       child: IconButton(
            //         onPressed: () {
            //           if (message.text.isNotEmpty) {
            //             if (role == 'patient') {
            //               FirebaseFirestore.instance
            //                   .collection("messages")
            //                   .doc(
            //                       "${FirebaseAuth.instance.currentUser?.phoneNumber}?${snapshot?.data['phone']}")
            //                   .collection("messagelist")
            //                   .add(
            //                 {
            //                   'message': message.text,
            //                   'image': null,
            //                   'sender': FirebaseAuth
            //                       .instance.currentUser?.phoneNumber,
            //                   'receiver': snapshot?.data['phone'],
            //                   'time': DateTime.now(),
            //                 },
            //               );
            //               message.clear();
            //             }
            //             if (role == 'doctor') {
            //               FirebaseFirestore.instance
            //                   .collection("messages")
            //                   .doc(
            //                       "${snapshot?.data['phone']}?${FirebaseAuth.instance.currentUser?.phoneNumber}")
            //                   .collection("messagelist")
            //                   .add(
            //                 {
            //                   'message': message.text,
            //                   'image': null,
            //                   'sender': FirebaseAuth
            //                       .instance.currentUser?.phoneNumber,
            //                   'receiver': snapshot?.data['phone'],
            //                   'time': DateTime.now(),
            //                 },
            //               );
            //               message.clear();
            //             }
            //           }
            //         },
            //         icon: const Icon(
            //           Icons.send_sharp,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
