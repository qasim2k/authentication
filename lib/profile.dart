import 'dart:io';

import 'package:authentication/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  Map? data;
  late final ab;
  File? _image;
  final picker = ImagePicker();
  String? downloadUrl;
  // Map? data;
  //  fetch()  {
  //   //print("jk");
  //   // data=await getdatafromstore.
  //   // fetchdata();
  //   setState(() {
  //     print("hhhhhhhhhhhhhhhhhhh");
  //    data =  getdatafromstore.fetchdata();
  //     print("returned");
  //    print(data.toString());
  //    print("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
  //   });

  //   // print(data.toString());
  // }

   postdata(String e, String imgurl) async {
    DateTime now = DateTime.now();
//String c=e.DateTime.now();
    String convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}-${now.microsecondsSinceEpoch.toString().padLeft(2, '0')}";
    print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    print(e + DateTime.now().toString());
    await FirebaseFirestore.instance
        .collection('post')
        .doc(e + " " + DateTime.now().toString())
        .set({
      'name': e, // John Doe
      // 'contact': "c", // Stokes and Sons
      'time': convertedDateTime, // 42
      'images': imgurl,
    });
    ab=null;
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadimg(File _image) async {
    String url;
    String imgid = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = await FirebaseStorage.instance
        .ref()
        .child('images')
        .child('profile$imgid');
    await reference.putFile(_image);
    url = await reference.getDownloadURL();
    return url;
  }

  Future getImagecamera() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
        print("jkjkjkjkjkjkjkj");
        print(data.toString());
      });
    });
  }

  @override
  void initState() {
    // fetch();
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        backgroundColor: Color.fromARGB(174, 42, 55, 109),
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
                              ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFhSnoly9J1ySaRA45scYB4Q1otdhWAXtLlg&usqp=CAU'
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
                      ),
                      CircleAvatar(
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
                    data == null ? "po" : data!['name'],
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 17, 14, 20),
                    ),
                  ),
                  Text(
                    'Flutter Developer',
                    style: TextStyle(
                      color: Color.fromARGB(255, 10, 193, 230),
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
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 239, 121, 121)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:138.0,right: 148,top: 7,bottom: 7),
                      child: Text(
                        "Add Post",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            elevation: 16,
                            child: Container(
                              height: 400.0,
                              width: 360.0,
                              child: Column(children: <Widget>[
                                SizedBox(height: 20),
                                Center(
                                  child: Text(
                                    "Create Your Post Here",
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 40.0,
                                      backgroundImage: NetworkImage(data == null
                                          ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFhSnoly9J1ySaRA45scYB4Q1otdhWAXtLlg&usqp=CAU'
                                          : data!['images']),
                                    ),
                                    Text("  "),
                                    Text(
                                      data == null ? "loading" : data!['name'],
                                      style: TextStyle(fontSize: 23),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      //icon: Icon(Icons.person),
                                      hintText: 'What,s on your mind?',
                                      //labelText: 'Name *',
                                    ),
                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                    validator: (String? value) {
                                      return (value != null &&
                                              value.contains('@'))
                                          ? 'Do not use the @ char.'
                                          : null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                          ),
                                          onPressed: () {var imgurl;
                                            getImage().whenComplete(() async {
                                               imgurl =
                                                  await uploadimg(_image!);
                                              ab = imgurl!;
                                            }).whenComplete(() => postdata(
                                                data == null
                                                    ? Text("loading")
                                                    : data!['name'],
                                                imgurl));
                                          },
                                          child: Icon(
                                            color: Colors.blue.shade400,
                                            Icons.photo,
                                            size: 33,
                                          )),
                                      TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                          ),
                                          onPressed: () {var imgurl;
                                            getImagecamera()
                                                .whenComplete(() async {
                                               imgurl =
                                                  await uploadimg(_image!);
                                             // ab = imgurl!;
                                            }).whenComplete(() => postdata(
                                                    data == null
                                                        ? Text("loading")
                                                        : data!['name'],
                                                    imgurl));
                                          },
                                          child: Icon(
                                            color: Colors.blue.shade400,
                                            Icons.camera_alt,
                                            size: 33,
                                          )),
                                    ],
                                  ),
                                ),
                                TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color.fromARGB(
                                                  255, 239, 121, 121)),
                                    ),
                                    onPressed: () {
                                      // getImagecamera()
                                      //     .whenComplete(() async {
                                      //   final imgurl =
                                      //       await uploadimg(_image!);
                                      //   ab = imgurl!;
                                      // }).whenComplete(() => postdata(
                                      //         data == null
                                      //             ? Text("loading")
                                      //             : data!['name'],
                                      //         ab));
                                    },
                                    child: Text(
                                      "Upload Post",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ]),
                            ),
                            
                          );
                        },
                      );
                    },
                  ),
                  // TextButton(
                  //     onPressed: () {
                  //       Get.to(post());
                  //     },
                  //     child: Text(
                  //       "data",
                  //       style: TextStyle(color: Colors.black),
                  //     ))
                  //Get.to(post());
                  // Divider(),
                  // NetworkImage(data == null
                  //             ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFhSnoly9J1ySaRA45scYB4Q1otdhWAXtLlg&usqp=CAU'
                  //             : data!['images']),
                  Image.network(
                    data == null
                              ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFhSnoly9J1ySaRA45scYB4Q1otdhWAXtLlg&usqp=CAU'
                              : data!['images'],fit: BoxFit.cover,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class profile extends StatefulWidget {
//   const profile({super.key});

//   @override
//   State<profile> createState() => _profileState();
// }

// class _profileState extends State<profile> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [Text("data")],
//       ),
//     );
//   }
// }
