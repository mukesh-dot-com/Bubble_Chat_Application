import 'package:bubble/views/footer_view.dart';
import 'package:flutter/material.dart';

import '../constants/route.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Appointments",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(searchRoute);
              },
              icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(
                  left: 15,
                  top: 7,
                ),
                leading: const CircleAvatar(
                  radius: 22,
                  child: Text('A'),
                ),
                title: const Text(
                  'Dr. Sandeep',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                subtitle: const Text('Wait While doctor let\'s you in'),
                horizontalTitleGap: 22,
                onTap: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(exploreRoute, (_) => false);
                },
                dense: true,
                enabled: true,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const FooterView(1),
    );
  }
}
