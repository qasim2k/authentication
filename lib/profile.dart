import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  Map? data;
  fetchdata() {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection //(teach == false? 'students': 'users');
        ('users');

    collectionReference
        .doc(FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        data = snapshot.data() as Map?;
      });

      print("jkjkjkjkjkjkjkj");
      print(data.toString());
    });
  }

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 10, 86, 157),
                  Color.fromARGB(255, 239, 163, 140)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.3, 0.6],
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => {Get.to(login())},
                    child: Column(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 15.0,
                        ),
                        Text("Log out"),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor:  Color.fromARGB(174, 42, 55, 109),
                      minRadius: 17.0,
                      child: InkWell(
                        onTap: () {
                          Get.to(login());
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 20.0,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(174, 42, 55, 109),
                      minRadius: 17.0,
                      child: Icon(
                        Icons.call,
                        size: 20.0,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 183, 110, 2),
                      minRadius: 60.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(data == null
                            ? 'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'
                            : data!['images']),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 135, 86, 107),
                      minRadius: 17.0,
                      child: Icon(
                        Icons.message,
                        size: 20.0,
                      ),
                    ),CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 135, 86, 107),
                      minRadius: 17.0,
                      child: Icon(
                        Icons.video_library_outlined,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  data!['name'],
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 230, 21, 21),
                  ),
                ),
                Text(
                  'Flutter Developer',
                  style: TextStyle(
                    color: Color.fromARGB(255, 230, 10, 10),
                    fontSize: 35,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 239, 4, 133),
                    child: ListTile(
                      title: Text(
                        '5000',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 244, 243, 246),
                        ),
                      ),
                      subtitle: Text(
                        'Followers',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 97, 7, 222),
                    child: ListTile(
                      title: Text(
                        '5000',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        'Following',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                 Image(
            image: AssetImage('assets/images/mypic.jpeg'),)
               // Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
