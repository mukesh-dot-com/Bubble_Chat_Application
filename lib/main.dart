import 'package:bubble/constants/route.dart';
import 'package:bubble/views/book_view.dart';
import 'package:bubble/views/chat_view.dart';
import 'package:bubble/views/contacts_view.dart';
import 'package:bubble/views/explore_view.dart';
import 'package:bubble/views/getstarted_view.dart';
import 'package:bubble/views/login_view.dart';
import 'package:bubble/views/message_view.dart';
import 'package:bubble/views/profile_view.dart';
import 'package:bubble/views/search_view.dart';
import 'package:bubble/views/setting_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      themeMode: ThemeMode.dark,
      home: const LoginView(),
      routes: {
        exploreRoute: (context) => const ExploreView(),
        searchRoute: (context) => const SearchView(),
        contactRoute: (context) => const ContactsView(),
        settingRoute: (context) => const SettingView(),
        chatRoute: (context) => const ChatView(),
        messageRoute: (context) => const MessageView(),
        profileRoute: (context) => const ProfileView(),
        bookRoute: (context) => const BookView(),
      },
    ),
  );
}
