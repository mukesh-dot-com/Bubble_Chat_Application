import 'package:bubble/views/footer_view.dart';
import 'package:flutter/material.dart';

class ContactsView extends StatefulWidget {
  String? role;
  ContactsView(this.role, {super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState(role);
}

class _ContactsViewState extends State<ContactsView> {
  int index = 2;
  String? role;
  _ContactsViewState(this.role);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Contacts',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: const Scaffold(),
      bottomNavigationBar: FooterView(2, role),
    );
  }
}
