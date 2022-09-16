
import 'package:authentication/login.dart';
import 'package:authentication/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Dashborad.dart';
import 'Resetpass.dart';

class Usermain extends StatefulWidget {
  const Usermain({Key? key}) : super(key: key);

  @override
  State<Usermain> createState() => _UsermainState();
}

class _UsermainState extends State<Usermain> {
  int _Selctedundex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Profile(),
    changePasword(),
  ];
  void _OnItemTapped(int index) {
    setState(() {
      _Selctedundex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Row(
          children: [
            Text("wellcome"),Padding(
              padding: const EdgeInsets.only(left:98.0),
              child: Icon(Icons.logout),
            ),
            TextButton(
                onPressed: () {
                  Get.to(login());
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_Selctedundex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Reset password',
          )
        ],
        currentIndex: _Selctedundex,
        selectedItemColor: Colors.amber,
        onTap: _OnItemTapped,
      ),
    );
  }
}
