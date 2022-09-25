// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class getdatafromstore{





//   static  fetchdata() {
//     Map? data;
//     CollectionReference collectionReference = FirebaseFirestore.instance
//         .collection //(teach == false? 'students': 'users');
//         ('users');

//     collectionReference
//         .doc(FirebaseAuth.instance.currentUser!.email)
//         .snapshots()
//         .listen((snapshot) {
    
//         data = snapshot.data() as Map?;
//            print("jkjkjkjkjkjkjkj");
//       print(data.toString());
      
      
//       });
//      // print(data.toString());
//       return data ;

   
    
//   }

  
// }