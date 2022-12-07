import 'package:flutter/material.dart';
import 'package:bubble/constants/route.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Column(
                      children: const [
                        CircleAvatar(
                          radius: 65,
                          backgroundImage: AssetImage('assets/doctor.jpg'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Dr. Sandeep',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 26),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Pshyciatrist',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'MBBS, Pshycology specialization, KIMS',
                            style: TextStyle(fontSize: 13),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.star),
                              const Icon(Icons.star),
                              const Icon(Icons.star),
                              const Icon(Icons.star),
                              const SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.comment_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 23,
                              ),
                              const Text(
                                ' 3+ Reviews',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 57, 52, 52)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              Column(
                children: const [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Track Record',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Treated Patients',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '300+',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Experience',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '3+Years',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                  Divider(
                    height: 30,
                    thickness: 1,
                  ),
                ],
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    child: Text(
                      'About Me',
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Flexible(
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur asjrng adipiscing elitna aliqua. Ut enim ad minim veniam, quis nostrud exeborquip',
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              const Text(
                'Book Slots',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 35,
                  child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        overlayColor: MaterialStatePropertyAll(Colors.red),
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 10,
                          ),
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 4,
                                color: Theme.of(context).primaryColor,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Text('Monday'),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 55,
                  child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        enableFeedback: true,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, right: 10),
                          height: 100,
                          width: 90,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).primaryColor)),
                            onPressed: () {},
                            child: const Text(
                              '10:00 Am',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(bookRoute);
                },
                child: const Text('View Slots'),
              ),
              const Divider(
                thickness: 1.3,
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      'Patient Reviews',
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        CircleAvatar(
                          radius: 23,
                          child: Text(
                            'A',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Patient A',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Flexible(
                        child: Text(
                          textAlign: TextAlign.justify,
                          'Lorem ipsum dolor sit amet, consectetur asjrng adipiscing elitna aliqua. Ut enim ad minim veniam, quis nostrud exeborquip',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1.3,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        CircleAvatar(
                          radius: 23,
                          child: Text(
                            'B',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Patient B',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Flexible(
                        child: Text(
                          textAlign: TextAlign.justify,
                          'Lorem ipsum dolor sit amet, consectetur asjrng adipiscing elitna aliqua. Ut enim ad minim veniam, quis nostrud exeborquip',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
