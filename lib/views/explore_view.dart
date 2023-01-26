import 'package:bubble/constants/route.dart';
import 'package:bubble/views/chat_view.dart';
import 'package:bubble/views/contacts_view.dart';
import 'package:bubble/views/footer_view.dart';
import 'package:bubble/views/profile_view.dart';
import 'package:bubble/views/setting_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExploreView extends StatefulWidget {
  String? role;
  ExploreView({super.key, required this.role});
  @override
  // ignore: no_logic_in_create_state
  State<ExploreView> createState() => _ExploreViewState(role);
}

class _ExploreViewState extends State<ExploreView> {
  String? role;
  _ExploreViewState(this.role);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(role);
  }

  final items = [
    'All',
    'General',
    'ENT',
    'OrthoPedic',
    'Dermatology',
    'Dentist'
  ];
  final user = FirebaseAuth.instance.currentUser;
  late bool flag = false;
  var photos = [
    'assets/doctor.jpg',
    'assets/ladyDoctor2.jpeg',
    'assets/ladyDoctor.jpg',
    'assets/doctor2.jpeg'
  ];
  String? value;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(role.toString())
            .doc(user?.phoneNumber)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: MySearchDelegate(),
                      );
                      // Navigator.of(context).restorablePushNamed(profileRoute);
                      // Navigator.of(context).pushNamed(searchRoute);
                    },
                  )
                ],
                centerTitle: true,
                title: const Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              drawer: Drawer(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  children: [
                    // const Icon(Icons.account_circle,
                    //     size: 120, color: Colors.purple),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: (snapshot.data?['image'] == null)
                              ? const NetworkImage(
                                  "https://th.bing.com/th/id/R.5ab3c6cef7371558452991283427f99a?rik=spJHOzCaiPrxRg&riu=http%3a%2f%2fwww.citylifecarehospital.com%2fcm-admin%2fuploads%2fimage%2f2131-10-doctor-icon-iconbunny.jpg&ehk=d4f4z7ssE4CYT3GFzcECCiy0hXItS3SqZdW5wkadXQ8%3d&risl=&pid=ImgRaw&r=0")
                              : NetworkImage(snapshot.data?['image']),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      snapshot.data?['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => SettingView(role)));
                        print(user?.phoneNumber);
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
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      //contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      title: const Text(
                        'Explore',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ChatView(role)));
                      },
                      title: const Text(
                        'Chat',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ContactsView(role)));
                      },
                      title: const Text(
                        'History',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => SettingView(role)));
                      },
                      title: const Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute, (route) => false);
                      },
                      title: const Text(
                        'SignOut',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
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
                          width: 350,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
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
                                    flag = false;
                                  },
                                );
                                if (this.value == 'All') {
                                  flag = true;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: (flag)
                            ? FirebaseFirestore.instance
                                .collection('doctor')
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection('doctor')
                                .where('specialisation', isEqualTo: this.value)
                                .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return const Text("Something Went Wrong");
                          }
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(3.0),
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProfileView(
                                        role,
                                        snapshot.data!.docs[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 160,
                                  margin: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 161, 70, 213),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10),
                                      bottom: Radius.circular(30),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                            image: (snapshot.data?.docs[index]
                                                        ['image'] ==
                                                    null)
                                                ? const NetworkImage(
                                                    "https://th.bing.com/th/id/R.5ab3c6cef7371558452991283427f99a?rik=spJHOzCaiPrxRg&riu=http%3a%2f%2fwww.citylifecarehospital.com%2fcm-admin%2fuploads%2fimage%2f2131-10-doctor-icon-iconbunny.jpg&ehk=d4f4z7ssE4CYT3GFzcECCiy0hXItS3SqZdW5wkadXQ8%3d&risl=&pid=ImgRaw&r=0")
                                                : NetworkImage(snapshot.data
                                                    ?.docs[index]['image']),
                                            alignment: Alignment.center,
                                            opacity: 0.9,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        //decoration: BoxDecoration(border: Border.all(width: 2)),
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data!.docs[index]['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 253, 244, 244),
                                                fontSize: 22,
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(2),
                                            ),
                                            Text(
                                              snapshot.data!
                                                  .docs[index]['specialisation']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.all(3)),
                                            SizedBox(
                                              height: 40,
                                              child: Text(
                                                snapshot
                                                    .data!.docs[index]['about']
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: const [
                                                    Icon(Icons.star),
                                                    Icon(Icons.star),
                                                    Icon(Icons.star),
                                                    Icon(Icons.star),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    TextButton(
                                                      style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.white),
                                                      ),
                                                      onPressed: () {},
                                                      child: Text(
                                                          (role == "doctor")
                                                              ? 'view'
                                                              : 'book'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: FooterView(0, role),
            );
          } else {
            return const Scaffold();
          }
        });
  }
}

class MySearchDelegate extends SearchDelegate {
  var photos = [
    'assets/doctor.jpg',
    'assets/ladyDoctor2.jpeg',
    'assets/ladyDoctor.jpg',
    'assets/doctor2.jpeg'
  ];
  List<String> searchResults = ['Uday Raj', 'mukesh', 'Mukesh Kumar', 'Jayam'];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            }
            query = '';
          },
        ),
      ];

  @override
  Widget buildResults(BuildContext context) => Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('doctor')
              .where('name', isEqualTo: query.trim())
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Text("Something Went Wrong");
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(3.0),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileView(
                            "patient", snapshot.data!.docs[index])));
                  },
                  child: Container(
                    height: 160,
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 161, 70, 213),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                        bottom: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage(
                                photos[(index) % photos.length],
                              ),
                              alignment: Alignment.center,
                              opacity: 0.9,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          //decoration: BoxDecoration(border: Border.all(width: 2)),
                          padding: const EdgeInsets.only(top: 8, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.docs[index]['name'].toString(),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 253, 244, 244),
                                  fontSize: 22,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(2)),
                              Text(
                                snapshot.data!.docs[index]['specialisation']
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              const Padding(padding: EdgeInsets.all(3)),
                              SizedBox(
                                height: 40,
                                child: Text(
                                  snapshot.data!.docs[index]['about']
                                      .toString(),
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.star),
                                      Icon(Icons.star),
                                      Icon(Icons.star),
                                      Icon(Icons.star),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      TextButton(
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed(profileRoute);
                                        },
                                        child: const Scaffold(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResults) {
      final result = searchResults.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);

      // stream: FirebaseFirestore.instance.collection('doctor').where('specialisation',isEqualTo: input).snapshots();
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
          },
        );
      },
    );
  }
}
