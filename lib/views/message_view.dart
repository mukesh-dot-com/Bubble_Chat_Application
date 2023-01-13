import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessageView extends StatefulWidget {
  const MessageView({super.key});
  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  _MessageViewState();

  // ignore: prefer_final_fields
  Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('time')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                itemBuilder: (_, index) {
                  QueryDocumentSnapshot qs = snapshot.data!.docs[index];
                  Timestamp t = qs['time'];
                  DateTime d = t.toDate();
                  print(d.toString());
                  return Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 300,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.purple,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    qs['message'],
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Text(
                                  d.hour.toString() + ":" + d.minute.toString(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}
