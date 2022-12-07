import 'package:bubble/views/footer_view.dart';
import 'package:flutter/material.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  int index = 2;
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
      bottomNavigationBar: const FooterView(2),
    );
  }
}
