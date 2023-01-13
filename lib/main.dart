import 'package:bubble/constants/route.dart';
import 'package:bubble/views/book_view.dart';
import 'package:bubble/views/chat_UI_view.dart';
import 'package:bubble/views/chat_view.dart';
import 'package:bubble/views/contacts_view.dart';
import 'package:bubble/views/explore_view.dart';
import 'package:bubble/views/form_view.dart';
import 'package:bubble/views/form_view_doctor.dart';
import 'package:bubble/views/getstarted_view.dart';
import 'package:bubble/views/login_view.dart';
import 'package:bubble/views/message_view.dart';
import 'package:bubble/views/otp_view.dart';
import 'package:bubble/views/role_view.dart';
import 'package:bubble/views/search_view.dart';
import 'package:bubble/views/setting_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      themeMode: ThemeMode.dark,
      home: checkUser(),
      routes: {
        messageRoute: (context) => const MessageView(),
        // profileRoute: (context) => const ProfileView(),
        bookRoute: (context) => const BookView(),
        otpRoute: (context) => const OTPView(),
        loginRoute: (context) => const LoginView(),
        roleRoute: (context) => const RoleView(),
        chatUIRoute: (context) => const ChatUserInterfaceView(),
      },
    ),
  );
}

checkUser() {
  if (FirebaseAuth.instance.currentUser == null) {
    print(FirebaseAuth.instance.currentUser);
    return const GetStartedView();
  } else {
    String? role;
    final snapShot = FirebaseFirestore.instance
        .collection("doctor")
        .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
        .get();
    if (snapShot == null) {
      role = "patient";
      return ExploreView(role: role);
    } else {
      role = "doctor";
      return ExploreView(role: role);
    }
  }
}
