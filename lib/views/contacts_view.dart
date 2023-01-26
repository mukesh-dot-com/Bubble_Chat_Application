import 'package:bubble/views/footer_view.dart';
import 'package:bubble/views/user_interface_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/route.dart';
import 'chat_UI_view.dart';
import 'dummy_chat_view.dart';

// ignore: must_be_immutable
class ContactsView extends StatefulWidget {
  String? role;
  ContactsView(this.role, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ContactsView> createState() => _ContactsViewState(role);
}

class _ContactsViewState extends State<ContactsView> {
  int index = 2;
  String? role;
  _ContactsViewState(this.role);

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'History',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
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
                                          DummyChatUserInterfaceView(
                                        snapshot,
                                        role,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                height: 105,
                                margin: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  // color: Color.fromARGB(255, 161, 70, 213),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10),
                                    bottom: Radius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      height: 55,
                                      width: 55,
                                      child: CircleAvatar(
                                        minRadius: 10,
                                        child: Text(
                                          snapshot.data?['name'][0],
                                          style: const TextStyle(
                                            fontSize: 28,
                                          ),
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
                                              // color: Color.fromARGB(
                                              //     255, 253, 244, 244),
                                              fontSize: 20,
                                            ),
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(2)),
                                          Text(
                                            snapshot.data?['specialisation'],
                                            style: const TextStyle(
                                              // color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const Text(
                                            "Previously chatted at 12th Feb 2023",
                                            style: TextStyle(
                                                // color: Colors.white,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.purple),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DummyChatUserInterfaceView(
                                                          snapshot, role),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              'View',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 20,
                                      thickness: 1,
                                      color: Color.fromARGB(255, 179, 178, 178),
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
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChatUserInterfaceView(
                                                snapshot, role)));
                                print("present");
                                // FirebaseFirestore.instance
                                //     .collection("requests")
                                //     .doc()
                                //     .set({});
                                // print(
                                //     snapshot2.data?.docs[index].toString());
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
                                      width: MediaQuery.of(context).size.width *
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
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(2)),
                                          const Padding(
                                              padding: EdgeInsets.all(3)),
                                          const Text(
                                            "You have chatted with this patient at 10th Feb 2023",
                                            style:
                                                TextStyle(color: Colors.white),
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
                                                  Navigator.of(context)
                                                      .pushNamed(profileRoute);
                                                },
                                                child:
                                                    const Text('View Profile'),
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
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  UserInterfaceView()));
                                                },
                                                child: const Text("View Chat"),
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
                        },
                      );
                    },
                  );
                }
                return const Scaffold();
              },
            ),
      bottomNavigationBar: FooterView(2, role),
    );
  }
}
