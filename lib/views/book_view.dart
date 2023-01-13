import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookView extends StatefulWidget {
  const BookView({super.key});

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  final user = FirebaseAuth.instance.currentUser;
  var days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Slots'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 45,
              child: ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      // print(user?.phoneNumber);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          days[index % days.length],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const Divider(
            height: 30,
            thickness: 2,
            color: Color.fromARGB(255, 136, 0, 167),
          ),
          const Text(
            'Morning',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 100,
            child: SizedBox(
              child: GridView.builder(
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisExtent: 50,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              '10am',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          const Divider(
            height: 30,
            thickness: 2,
            color: Color.fromARGB(255, 155, 135, 158),
          ),
          const Text(
            'Afternoon',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 100,
            child: SizedBox(
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisExtent: 50,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              '1pm',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          const Divider(
            height: 50,
            thickness: 2,
            color: Color.fromARGB(255, 155, 135, 158),
          ),
          const Text(
            'Evening',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 100,
            child: SizedBox(
              child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisExtent: 50,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              '5pm',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
