import 'dart:convert';
import 'package:bubble/views/chat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  QueryDocumentSnapshot<Object?> docs;
  String? role;
  ProfileView(this.role, this.docs, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ProfileView> createState() => _ProfileViewState(role, docs);
}

class _ProfileViewState extends State<ProfileView> {
  QueryDocumentSnapshot<Object?> docs;
  String? role;
  _ProfileViewState(this.role, this.docs);
  String? mtoken = "";
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin fltNotification =
      FlutterLocalNotificationsPlugin();
  var days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  int time = 1;

  @override
  void initState() {
    print(role);
    super.initState();
    requestPermission();
    getToken();
    initMessaging();
  }

  void pushSendMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAOV71c80:APA91bEQP_q8VRu2A6dexMANr2NloMKowNRMFmUNs23WkSpMlEoafgU5rr1-S2h8snJ_cF-54doMwASJ4gqeLbnQufC3o3Wr7SzRkhbMBIF184A4AYgeyPtd87Rr1Z1kx3RDq3HkEa_P'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "dbfood"
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
  }

  void initMessaging() {
    var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSetting = InitializationSettings(android: androiInit);
    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initSetting);
    var androidDetails = const AndroidNotificationDetails('1', 'channelName');
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        fltNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails);
      }
      fltNotification.initialize(initSetting,
          onDidReceiveNotificationResponse: (message) {
        print("Present here pls recognize me");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChatView(role)));
      });
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print("My token is $mtoken");
      });
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
        .set({
      'token': token,
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 65,
                          backgroundImage: (docs['image'] == null)
                              ? const NetworkImage(
                                  "https://th.bing.com/th/id/R.5ab3c6cef7371558452991283427f99a?rik=spJHOzCaiPrxRg&riu=http%3a%2f%2fwww.citylifecarehospital.com%2fcm-admin%2fuploads%2fimage%2f2131-10-doctor-icon-iconbunny.jpg&ehk=d4f4z7ssE4CYT3GFzcECCiy0hXItS3SqZdW5wkadXQ8%3d&risl=&pid=ImgRaw&r=0")
                              : NetworkImage(docs['image']),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            docs['name'].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 26),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            docs['specialisation'].toString(),
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                docs['email'].toString(),
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.star),
                              const Icon(Icons.star),
                              const Icon(Icons.star),
                              const Icon(Icons.star),
                              const SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.comment_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 23,
                              ),
                              const Text(
                                ' 3+ Reviews',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 57, 52, 52)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              Column(
                children: const [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Track Record',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Treated Patients',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '300+',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Experience',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '3+Years',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                  Divider(
                    height: 30,
                    thickness: 1,
                  ),
                ],
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    child: Text(
                      'About Me',
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        docs['about'].toString(),
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              const Text(
                'Book Slots',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 35,
                  child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        overlayColor:
                            const MaterialStatePropertyAll(Colors.red),
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 10,
                          ),
                          width: 112,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 4,
                                color: Theme.of(context).primaryColor,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Text(
                              days[index % days.length],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 55,
                  child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        enableFeedback: true,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, right: 10),
                          height: 100,
                          width: 90,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).primaryColor)),
                            onPressed: () {},
                            child: const Text(
                              '10:00 Am',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (role == "patient")
                TextButton(
                  onPressed: () async {
                    pushSendMessage(
                        "fx-kbMpYTE2jMLtUmFlQzJ:APA91bFz-DNpIyTc0uFdOMhWlWvAASo2tjWaMixQilnWurcO-eJcQh8HzXapKjkKwP4GF6ru7WzBBE0k8mFCImtYkmyzjlYIZJajpvqUNvlHRYGXrC_Z__AEBQ4U150Rj4joUP-P7ziB",
                        "Hey ${docs['name']}",
                        "Someone is waiting for your appointment, Click on this notification to get into App");
                    await FirebaseFirestore.instance
                        .collection("requests")
                        .doc(
                            "${FirebaseAuth.instance.currentUser?.phoneNumber}?${docs['phone']}")
                        .set(
                      {
                        'patient_id':
                            FirebaseAuth.instance.currentUser?.phoneNumber,
                        'doctor_id': docs['phone'].toString(),
                        'checked': false,
                      },
                    );
                    await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => ChatView(role)));
                  },
                  child: const Text('Book'),
                ),
              const Divider(
                thickness: 1.3,
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      'Patient Reviews',
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        CircleAvatar(
                          radius: 23,
                          child: Text(
                            'A',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Patient A',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Flexible(
                        child: Text(
                          textAlign: TextAlign.justify,
                          'Lorem ipsum dolor sit amet, consectetur asjrng adipiscing elitna aliqua. Ut enim ad minim veniam, quis nostrud exeborquip',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1.3,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        CircleAvatar(
                          radius: 23,
                          child: Text(
                            'B',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Patient B',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Flexible(
                        child: Text(
                          textAlign: TextAlign.justify,
                          'Lorem ipsum dolor sit amet, consectetur asjrng adipiscing elitna aliqua. Ut enim ad minim veniam, quis nostrud exeborquip',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
