import 'package:bubble/constants/route.dart';
import 'package:bubble/views/profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListStyleView extends StatefulWidget {
  const ListStyleView({super.key});

  @override
  State<ListStyleView> createState() => _ListStyleViewState();
}

/*final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

ListView.builder(
  padding: const EdgeInsets.all(8),
  itemCount: entries.length,
  itemBuilder: (BuildContext context, int index) {
    return Container(
      height: 50,
      color: Colors.amber[colorCodes[index]],
      child: Center(child: Text('Entry ${entries[index]}')),
    );
  }
);*/

class _ListStyleViewState extends State<ListStyleView> {
  var photos = [
    'assets/doctor.jpg',
    'assets/ladyDoctor2.jpeg',
    'assets/ladyDoctor.jpg',
    'assets/doctor2.jpeg'
  ];
  var names = ['Dr. Sandeep', 'Dr. Regina', 'Dr. Jenna Ortega', 'Dr. Simons'];
  var itemCount = 4;

  final fireStore = FirebaseFirestore.instance.collection('doctor').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStore,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return const Text("Something Went Wrong");
        }
        return ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(3.0),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProfileView(snapshot.data!.docs[index])));
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
                              snapshot.data!.docs[index]['about'].toString(),
                              style: const TextStyle(color: Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(profileRoute);
                                    },
                                    child: const Text('Book'),
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
    );
  }
}
