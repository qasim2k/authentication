import 'package:flutter/material.dart';

class home extends StatelessWidget {
   home({ Key? key }) : super(key: key);

  final List<Map> myProducts =
      List.generate(100000, (index) => {"id": index, "name": "Product $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey,
        title: const Text('home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // implement GridView.builder
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 169, 200, 226),
                    borderRadius: BorderRadius.circular(15)),
               child:  SingleChildScrollView(
                 child: Column(
                   children: [
                     Text(myProducts[index]["name"]),
                     Image.network("https://gifimage.net/wp-content/uploads/2018/10/blinking-eye-animated-gif-2.gif", fit:BoxFit.cover,)
                            
                   ],
                 ),
               ),
               
              );
            }),
      ),
    );
  }
}


// import 'package:flutter/material.dart';  

  
// class MyApp extends StatelessWidget {  
  
//   List<String> images = [  
//     "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",  
//     "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",  
//     "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",  
//     "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"  
//   ];  
  
//   @override  
//   Widget build(BuildContext context) {  
//     return Scaffold(  
     
//         appBar: AppBar(  
//           title: Text("Flutter GridView Demo"),  
//           backgroundColor: Colors.red,  
//         ),  
//         body: Container(  
//             padding: EdgeInsets.all(12.0),  
//             child: GridView.builder(  
//               itemCount: images.length,  
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
//                   crossAxisCount: 2,  
//                   crossAxisSpacing: 4.0,  
//                   mainAxisSpacing: 4.0  
//               ),  
//               itemBuilder: (BuildContext context, int index){  
//                 return Image.network(images[index]);  
//               },  
//             )),  
      
//     );  
//   }  
// }  