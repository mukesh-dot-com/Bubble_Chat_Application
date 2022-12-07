import 'package:bubble/constants/route.dart';
import 'package:bubble/views/footer_view.dart';
import 'package:bubble/views/list_view.dart';
import 'package:flutter/material.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});
  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  final items = ['General', 'Ear Nose Throat', 'OrthoPedic'];
  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(searchRoute);
            },
            icon: const Icon(Icons.search_rounded),
          )
        ],
        centerTitle: true,
        title: const Text(
          "Explore",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        /*shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        toolbarHeight: 70,*/
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 60),
          children: [
            const Icon(Icons.account_circle, size: 120, color: Colors.purple),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Pradeep',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).restorablePushNamed(profileRoute);
              },
              child: const Text(
                'View Profile >',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            /*Divider(
              height: 40,
              thickness: 2,
              color: Theme.of(context).primaryColor,
            ),*/
            ListTile(
              onTap: () {},
              //contentPadding: EdgeInsets.symmetric(horizontal: 30),
              title: const Text(
                'Explore',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                'Chat',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                'History',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                'Settings',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Select Category',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  width: 295,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.purple,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      focusColor: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      value: value,
                      items: items.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      hint: const Text("Select Category"),
                      onChanged: (value) {
                        setState(
                          () {
                            this.value = value;
                          },
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                  margin: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(child: ListStyleView()),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Create Group',
                    textAlign: TextAlign.left,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Create'),
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      */
      bottomNavigationBar: const FooterView(0),
    );
  }
}
