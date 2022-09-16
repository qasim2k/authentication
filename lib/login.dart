
import 'package:authentication/profile.dart';
import 'package:authentication/resetpass.dart';
import 'package:authentication/signup.dart';
import 'package:authentication/user/usermain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formkey = GlobalKey<FormState>();
  var email;
  var password;
  final emailController = TextEditingController();
  final passController = TextEditingController(); 
  
  // 
   signnin() async {
    //print('1');
    if (email != null) {
      // print('2');
      try {
        // print('passed');
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        //  print('not Passed');
Get.to(profile());
      } catch (ex) {
        //  print('3');
        print(ex);
      }
    }
  }
  
  @override
  void dispose(){
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key:_formkey,
        child: Padding(
          padding: const EdgeInsets.only(top: 78.0, left: 25, right: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Sign In",
                  style: TextStyle(
                      color: Color.fromARGB(255, 60, 8, 109),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
               Image(
            image: AssetImage('assets/images/login.gif'),
          ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "  xyz@gmail.com",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 24, 22, 22), // <-- Change this
                        fontSize: 28,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      suffix: Icon(Icons.email),
                    ),
                    controller: emailController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return('please enter email');
                      }else if(!value.contains("@")){return('enter valid email');

                      }
                      return null;
                    },
                  ),
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
                        suffix: Icon(Icons.remove_red_eye)
                        ),
                        controller: passController,
                        validator: (value){
                          if(value==null || value.isEmpty){
                            Fluttertoast.showToast(
              msg: "enter password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 14.0,
            );
                            return('enter password');
                            
                          }else if (value.length<4){Fluttertoast.showToast(
              msg: "enter strong password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 14.0,
            );
                            return('enter 4 digit password');
                          }
                        },
                  ),
                ),
                SizedBox(height: 12),
                  InkWell
                  (child: Text("forgot password?click here"),onTap: (){
                    Get.to(resetpass());
                  },
                  ),SizedBox(height: 12,),
                ElevatedButton(
                  child: Text("LOGIN"),
                  onPressed: () {
                    // print();
                    if (_formkey.currentState!.validate()){
                      email=emailController.text;
                     // print(email.toString());
                      password=passController.text;
                      print(email+"..."+ password);
                     // Get.to(Usermain()); 
                     signnin();
                    }
                   
                    
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      primary: Color.fromRGBO(103, 58, 183, 1)),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  child: Text("SignUp"),
                  onPressed: () {
                    Get.to(signup());
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      primary: Colors.deepPurple),
                ),
                
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
