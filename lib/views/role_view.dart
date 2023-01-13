import 'package:bubble/constants/route.dart';
import 'package:bubble/views/form_view.dart';
import 'package:bubble/views/form_view_doctor.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RoleView extends StatefulWidget {
  const RoleView({super.key});

  @override
  State<RoleView> createState() => _RoleViewState();
}

class _RoleViewState extends State<RoleView> {
  int selectedIndex = -1;
  bool notSet = false;
  String? role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Column(
              children: const [
                Text(
                  "Choose Your Role",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            Container(
              height: 400,
              width: 500,
              margin: const EdgeInsets.only(
                top: 40,
                left: 30,
              ),
              child: Lottie.network(
                "https://assets7.lottiefiles.com/packages/lf20_zpjfsp1e.json",
                fit: BoxFit.fill,
                repeat: false,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex =
                      (selectedIndex != -1 && selectedIndex != 2) ? -1 : 1;
                  role = "doctor";
                });
              },
              child: Container(
                height: 55,
                width: 450,
                margin: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 30,
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1.5,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: selectedIndex == 1
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
                child: Text(
                  "Doctor",
                  style: TextStyle(
                    fontSize: 25,
                    color: selectedIndex == 1 ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex =
                      (selectedIndex != -1 && selectedIndex != 1) ? -1 : 2;
                  role = "patient";
                });
              },
              child: Container(
                height: 55,
                width: 400,
                margin: const EdgeInsets.symmetric(
                  horizontal: 60,
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1.5,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: selectedIndex == 2
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
                child: Text(
                  "Patient",
                  style: TextStyle(
                    fontSize: 25,
                    color: selectedIndex == 2 ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 35,
              ),
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: TextButton(
                onPressed: () {
                  if (selectedIndex != -1) {
                    if (selectedIndex == 1) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FormDoctorView(role: role),
                        ),
                      );
                    }
                    if (selectedIndex == 2) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FormView(role: role),
                        ),
                      );
                    }
                  } else {
                    notSet = true;
                  }
                },
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (notSet)
              const Text(
                "Choose any option",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
