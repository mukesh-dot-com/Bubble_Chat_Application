import 'package:bubble/constants/route.dart';
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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(3.0),
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(profileRoute);
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage('assets/doctor.jpg'),
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
                      const Text(
                        'Dr.Sandeep',
                        style: TextStyle(
                          color: Color.fromARGB(255, 253, 244, 244),
                          fontSize: 22,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(2)),
                      const Text(
                        'MBBS/Physiciatrist',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      const Padding(padding: EdgeInsets.all(3)),
                      const SizedBox(
                        height: 40,
                        child: Text(
                          'Currently Working in XYZ Hospital since 5 years, has 8 years plus experience askngksagk',
                          style: TextStyle(color: Colors.white),
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
                                        MaterialStatePropertyAll(Colors.white)),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(profileRoute);
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
  }
}
