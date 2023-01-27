import 'package:bubble/views/chat_UI_view.dart';
import 'package:bubble/views/footer_view.dart';
import 'package:bubble/views/patient_details_view.dart';
import 'package:bubble/views/setting_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../constants/route.dart';

// ignore: must_be_immutable
class ChatView extends StatefulWidget {
  String? role;
  ChatView(this.role, {super.key});
  @override
  // ignore: no_logic_in_create_state
  State<ChatView> createState() => _ChatViewState(role);
}

class _ChatViewState extends State<ChatView> {
  final int currentIndex = 2;
  String? role;
  bool checked = false;
  _ChatViewState(this.role);
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Appointments",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.of(context).pushNamed(searchRoute);
        //       },
        //       icon: const Icon(Icons.search_rounded))
        // ],
      ),
      body: (role == "patient")
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("requests")
                  .where('patient_id', isEqualTo: user?.phoneNumber)
                  .snapshots(),
              builder: (context, snapshot2) {
                if (snapshot2.data != null) {
                  return ListView.builder(
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot2.data?.docs.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("doctor")
                            .doc(snapshot2.data?.docs[index]['doctor_id'])
                            .get()
                            .asStream(),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return InkWell(
                              onTap: () {
                                if (snapshot2.data?.docs[index]["checked"]) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChatUserInterfaceView(
                                        snapshot,
                                        role,
                                      ),
                                    ),
                                  );
                                } else {
                                  showWait(context);
                                }
                              },
                              child: Container(
                                height: 160,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: (snapshot2.data?.docs[index]
                                          ['checked'])
                                      ? const Color.fromARGB(255, 161, 70, 213)
                                      : Colors.grey,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10),
                                    bottom: Radius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: (snapshot.data?['image'] ==
                                                  null)
                                              ? const NetworkImage(
                                                  "https://th.bing.com/th/id/R.5ab3c6cef7371558452991283427f99a?rik=spJHOzCaiPrxRg&riu=http%3a%2f%2fwww.citylifecarehospital.com%2fcm-admin%2fuploads%2fimage%2f2131-10-doctor-icon-iconbunny.jpg&ehk=d4f4z7ssE4CYT3GFzcECCiy0hXItS3SqZdW5wkadXQ8%3d&risl=&pid=ImgRaw&r=0")
                                              : NetworkImage(
                                                  snapshot.data?['image']),
                                          alignment: Alignment.center,
                                          opacity: 0.9,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      //decoration: BoxDecoration(border: Border.all(width: 2)),
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data?['name'],
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 253, 244, 244),
                                              fontSize: 22,
                                            ),
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(2)),
                                          Text(
                                            snapshot.data?['specialisation'],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(3)),
                                          const SizedBox(
                                            height: 50,
                                            child: Text(
                                              "we have sent notification to doctor wait until doctor let's you in",
                                              style: TextStyle(
                                                  color: Colors.white),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              (snapshot2.data?.docs[index]
                                                      ['checked'])
                                                  ? TextButton(
                                                      style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ChatUserInterfaceView(
                                                                    snapshot,
                                                                    role),
                                                          ),
                                                        );
                                                      },
                                                      child: const Text('Chat'),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const SingleChildScrollView();
                          }
                        },
                      );
                    },
                  );
                } else {
                  return const Scaffold();
                }
              },
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("requests")
                  .where('doctor_id', isEqualTo: user?.phoneNumber)
                  .snapshots(),
              builder: (context, snapshot2) {
                if (snapshot2.data != null) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot2.data?.docs.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("patient")
                              .doc(snapshot2.data?.docs[index]['patient_id'])
                              .get()
                              .asStream(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return InkWell(
                                onTap: () {
                                  if (snapshot2.data?.docs[index]["checked"]) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChatUserInterfaceView(
                                                    snapshot, role)));
                                  } else {
                                    print("present");
                                    // FirebaseFirestore.instance
                                    //     .collection("requests")
                                    //     .doc()
                                    //     .set({});
                                    // print(
                                    //     snapshot2.data?.docs[index].toString());
                                  }
                                },
                                child: Container(
                                  height: 150,
                                  margin: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 161, 70, 213),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10),
                                      bottom: Radius.circular(30),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              snapshot.data?['image'],
                                            ),
                                            alignment: Alignment.center,
                                            opacity: 0.9,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        //decoration: BoxDecoration(border: Border.all(width: 2)),
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data?['name'],
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 253, 244, 244),
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.all(2)),
                                            const Padding(
                                                padding: EdgeInsets.all(3)),
                                            const Text(
                                              "Hello Doctor, I am waiting for you to let me in.",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  style: const ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PatientDetailsView(
                                                          snapshot
                                                              .data?['phone'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                      'View Profile'),
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                TextButton(
                                                  style: const ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.white),
                                                  ),
                                                  onPressed: () async {
                                                    if (!snapshot2
                                                            .data?.docs[index]
                                                        ['checked']) {
                                                      print(
                                                          "${snapshot2.data?.docs[index]['patient_id']}?${user?.phoneNumber}");
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              "requests")
                                                          .doc(
                                                              "${snapshot2.data?.docs[index]['patient_id']}?${user?.phoneNumber}")
                                                          .update(
                                                        {
                                                          'checked': true,
                                                        },
                                                      );
                                                    } else {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChatUserInterfaceView(
                                                                  snapshot,
                                                                  role),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: (!snapshot2
                                                              .data?.docs[index]
                                                          ['checked'])
                                                      ? const Text("Enable")
                                                      : const Text("Chat"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const SingleChildScrollView();
                            }
                          });
                    },
                  );
                }
                return const Scaffold();
              },
            ),
      bottomNavigationBar: FooterView(1, role),
    );
  }
}

void showWait(context) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    text: "Doctor hasn't accepted your request, please wait for sometime",
    // confirmBtnText: "",
    confirmBtnColor: Colors.purple,
  );
}
