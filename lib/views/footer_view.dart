import 'package:bubble/views/chat_view.dart';
import 'package:bubble/views/contacts_view.dart';
import 'package:bubble/views/explore_view.dart';
import 'package:bubble/views/setting_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FooterView extends StatefulWidget {
  final int index;
  String? role;
  FooterView(this.index, this.role, {super.key});
  @override
  // ignore: no_logic_in_create_state
  State<FooterView> createState() => _FooterViewState(index, role);
}

class _FooterViewState extends State<FooterView> {
  int _currentIndex;
  String? role;
  _FooterViewState(this._currentIndex, this.role);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.travel_explore_rounded),
          label: "Explore",
          backgroundColor: Color.fromARGB(255, 198, 42, 250),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          label: "Chat",
          backgroundColor: Color.fromARGB(255, 199, 42, 251),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.history_rounded),
          label: "History",
          backgroundColor: Color.fromARGB(255, 198, 54, 246),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
          backgroundColor: Color.fromARGB(255, 197, 43, 249),
        ),
      ],
      onTap: (index) {
        setState(
          () {
            if (_currentIndex == index) {
            } else {
              _currentIndex = index;
              if (_currentIndex == 0) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ExploreView(role: role)));
              } else if (_currentIndex == 1) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ChatView(role)));
              } else if (_currentIndex == 2) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ContactsView(role)));
              } else if (_currentIndex == 3) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SettingView(role)));
              }
            }
          },
        );
      },
    );
  }
}
