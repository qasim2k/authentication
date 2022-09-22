
import 'package:authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class resetpass extends StatefulWidget {
  const resetpass({Key? key}) : super(key: key);

  @override
  State<resetpass> createState() => _resetpassState();
}

class _resetpassState extends State<resetpass> {
  final _formkey = GlobalKey<FormState>();
  var resetemail;
  final resetemailcontroller = TextEditingController();
  @override
  void dispose() {
    resetemailcontroller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("reset-pass"),
      ),
      body: Column(
        children: [
          Center(
            child: const Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("reset link will be sent to your email adress"),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: const Image(width: 50,height: 43,
            image: AssetImage('assets/images/reset.gif'),
          ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "email addres",
                    fillColor: Colors.amber,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  controller: resetemailcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      Fluttertoast.showToast(
                        msg: 'Enter mail to send reset link',
                        textColor: Colors.blueGrey,
                        gravity: ToastGravity.SNACKBAR,
                      );
                      return ('Enter Email to send reset link');
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 78.0),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 103, 58, 183))),
                  onPressed: () {
                    if (_formkey.currentState!.validate()){
                      setState(() {
                        resetemail=resetemailcontroller.text;
                      });
                    } ;
                    print("resetemail>>"+resetemail);
                  },
                  child: Text(
                    "send Email",
                    style: TextStyle(color: Color.fromARGB(255, 245, 242, 245)),
                  ),
                ),
              ),
              TextButton(onPressed: () {Get.to(login());}, child: Text("Login"))
            ],
          ),
          SizedBox(
            height: 12,
          ),
          TextButton(
           
            onPressed: () {
              Get.to(login());
            },
            child: Text(
              "Dont't have account ? signup ",
              style: TextStyle(color: Color.fromARGB(255, 112, 87, 224)),
            ),
          ),
        ],
      ),
    );
  }
}
