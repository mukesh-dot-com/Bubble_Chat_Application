import 'package:bubble/views/message_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatUserInterfaceView extends StatefulWidget {
  const ChatUserInterfaceView({Key? key}) : super(key: key);

  @override
  State<ChatUserInterfaceView> createState() => _ChatUserInterfaceViewState();
}

class _ChatUserInterfaceViewState extends State<ChatUserInterfaceView> {
  TextEditingController message = TextEditingController();

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
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Amarnath",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Online",
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
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              //should implement code here,
              child: const MessageView(),
            ),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).primaryColor),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: message,
                    decoration: InputDecoration(
                      hintText: 'Enter your message here..',
                      enabled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (message.text.isNotEmpty) {
                        FirebaseFirestore.instance.collection("messages").add({
                          'message': message.text,
                          'sender':
                              FirebaseAuth.instance.currentUser?.phoneNumber,
                          'time': DateTime.now(),
                        });
                        message.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.send_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
