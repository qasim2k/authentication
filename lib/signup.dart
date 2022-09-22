// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'login.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroler = TextEditingController();
  final passcontroler = TextEditingController();
  final namecontroler = TextEditingController();
  final contactcontroler = TextEditingController();
  final agecontroler = TextEditingController();
  var email;
  var pass;
  String? contact;
  String? name;
  String? age;

  @override
  void dispose() {
    emailcontroler.dispose();
    passcontroler.dispose();
    super.dispose();
  }

  static addUser(String e,String n,String c, String a, String imgurl) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(e)
        .set({
          'name': n, // John Doe 
          'contact': c, // Stokes and Sons
          'age': a, // 42
          'images': imgurl,
        });
  }

  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  // Future<void> addUser() async{
  //   final imgurl = await uploadimg(_image!);
  //   return users
  //       .add({
  //         'name': name, // John Doe 
  //         'contact': contact, // Stokes and Sons
  //         'age': age, // 42
  //         'images': imgurl,
  //       })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

   

  registration() async {
    if (email != null) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass);
            //Get.to(login());
        //  print('not Passed');

      } catch (ex) {
        //  print('3');
        print(ex);
      }
    }
  }

  File? _image;
  final picker = ImagePicker();
  String? downloadUrl;

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

  void adddata() {}
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

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Form(
                key: _formkey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color.fromARGB(255, 60, 8, 109),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              // child: ?_image==null:

                              InkWell(
                                // onTap: getImage,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 70.0,
                                  child: CircleAvatar(
                                    radius: 68.0,
                                    child: ClipOval(
                                      child: (_image != null)
                                          ? Image.file(
                                              _image!,
                                              width: 160,
                                              height: 140,
                                              fit: BoxFit.fill,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.photo_camera,
                                                  size: 54,
                                                ),
                                                Text(
                                                  "upload photo!!",
                                                  style:
                                                      TextStyle(fontSize: 7.5),
                                                )
                                              ],
                                            ),
                                    ),
                                    // backgroundColor: Color.fromARGB(255, 177, 104, 104),
                                  ),
                                ),
                              ),

                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.deepPurple)),
                                  onPressed: () {
                                    getImage().whenComplete(() {
                                      uploadimg(_image!);
                                    });
                                  },
                                  child: Text("upload profile pic")),
                              SizedBox(
                                height: 14,
                              )
                            ],
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "  xyz@gmail.com",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(
                                    255, 24, 22, 22), // <-- Change this
                                fontSize: 28,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              suffix: Icon(Icons.email),
                            ),
                            controller: emailcontroler,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ('enter email');
                              } else if (!value.contains('@')) {
                                return ('enter valid email');
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "   password",
                                  hintStyle: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 15,
                                      color: Color.fromARGB(255, 192, 9, 9),
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  suffix: Icon(Icons.remove_red_eye)),
                              onChanged: (value) {},
                              controller: passcontroler,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  // Fluttertoast.showToast(
                                  //     msg: 'enter pass',
                                  //     gravity: ToastGravity.CENTER,
                                  //     backgroundColor:
                                  //         Color.fromARGB(255, 151, 157, 240));
                                  return ('enter password');
                                } else if (value.length < 4) {
                                  return ('password must be greater then 4 digits');
                                }
                                return null;
                              },
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "  Name",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(
                                    255, 24, 22, 22), // <-- Change this
                                fontSize: 28,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              suffix: Icon(Icons.person),
                            ),
                            controller: namecontroler,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                // Fluttertoast.showToast(
                                //   msg: 'name?',
                                //   backgroundColor:
                                //       Color.fromARGB(255, 11, 12, 12),
                                //   fontSize: 12,
                                //   gravity: ToastGravity.CENTER,
                                // );
                                return ('name');
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "  contact number",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(
                                    255, 24, 22, 22), // <-- Change this
                                fontSize: 28,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              suffix: Icon(Icons.contact_phone),
                            ),
                            controller: contactcontroler,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                // Fluttertoast.showToast(
                                //   msg: 'enter contact num',
                                //   backgroundColor:
                                //       Color.fromARGB(255, 11, 12, 12),
                                //   fontSize: 12,
                                //   gravity: ToastGravity.CENTER,
                                // );
                                return ('contact num?');
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "  age",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(
                                    255, 24, 22, 22), // <-- Change this
                                fontSize: 28,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              suffix: Icon(Icons.rule),
                            ),
                            controller: agecontroler,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                // Fluttertoast.showToast(
                                //   msg: 'age?',
                                //   backgroundColor:
                                //       Color.fromARGB(255, 11, 12, 12),
                                //   fontSize: 12,
                                //   gravity: ToastGravity.CENTER,
                                // );
                                return ('age?');
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(height: 12),
                          ElevatedButton(
                            child: Text("signup"),
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  email = emailcontroler.text;
                                  pass = passcontroler.text;
                                  name = namecontroler.text;
                                  contact = contactcontroler.text;
                                  age = agecontroler.text;
                                });
                                final imgurl = await uploadimg(_image!);
                                registration().whenComplete(() => addUser(email!,name!,contact!,age!, imgurl!));
                              }
                              // Get.to(home());
                            },
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.0, vertical: 20.0),
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                // ignore: deprecated_member_use
                                primary: Colors.deepPurple),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(login());
                            },
                            child: Text("Login"),
                            // ignore: duplicate_ignore, duplicate_ignore
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.0, vertical: 20.0),
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                // ignore: deprecated_member_use
                                primary: Colors.deepPurple),
                          )
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
