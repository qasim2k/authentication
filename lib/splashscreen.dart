import 'dart:async';

import 'package:flutter/material.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {  
  @override  
  SplashScreenState createState() => SplashScreenState();  
}  
class SplashScreenState extends State<SplashScreen> {  
  @override  
  void initState() {  
    super.initState();  
    Timer(Duration(seconds: 10),  
            ()=>Navigator.pushReplacement(context,  
            MaterialPageRoute(builder:  
                (context) => login()  
            )  
         )  
    );  
  }  
  @override  
  Widget build(BuildContext context) {  
    return Container(  color: Color.fromARGB(255, 255, 254, 251),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [  Padding(
          padding: const EdgeInsets.only(top:238.0),
          child: Image.network("https://www.technig.com/wp-content/uploads/2017/03/how-to-create-css-preloader.gif"),
        )
     
       ],),
      

        //child:FlutterLogo(size:MediaQuery.of(context).size.height)  
    );  
  }  
}  