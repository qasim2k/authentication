import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';

class post extends StatefulWidget {
  const post({super.key});

  @override
  State<post> createState() => _postState();
}

class _postState extends State<post> {
  Map? data;
  late final ab;
  File? _image;
  final picker = ImagePicker();
  String? downloadUrl;
//void adddata() {}

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

  static postdata(String e, String imgurl) async {
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
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
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

        // if (data == null) {
        //   CircularProgressIndicator();
        // } else {
        //   data = snapshot.data() as Map?;
        // }
      });

      print("jkjkjkjkjkjkjkj");
      print(data.toString());
      print(DateTime.now());
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Add your post"),
          Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundImage: NetworkImage(data == null
                    ? 'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'
                    : data!['images']),
              ),
              Text("  "),
              Text(
                data == null ? "loading" : data!['name'],
                style: TextStyle(fontSize: 23),
              )
            ],
          ),
          TextFormField(
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
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
          SizedBox(
            height: 13,
          ),
          ElevatedButton(
              onPressed: () {
                getImage().whenComplete(() async {
                  final imgurl = await uploadimg(_image!);
                  ab = imgurl!;
                }).whenComplete(() => postdata(
                    data == null ? Text("loading") : data!['name'], ab));
              },
              child: Icon(
                Icons.photo,
                size: 23,
              )),
          // InkWell(onTap: getImage().whenComplete(() {
          //                             uploadimg(_image!);
          //                           });
          //   child: Icon(
          //     Icons.photo_sharp,
          //     size: 50,
          //     color: Colors.blue,
          //   ),
          // )
        ],
      ),
    );
  }
}
