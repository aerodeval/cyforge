import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr/Screen/SignInPage.dart';
import 'package:ocr/Screen/documentType.dart';
import 'package:ocr/Screen/recognization_page.dart';
import 'package:ocr/Screen/stepper.dart';
import 'package:ocr/Utils/backend.dart';
import 'package:ocr/Utils/image_cropper_page.dart';
import 'package:ocr/Utils/image_picker_class.dart';
import 'package:ocr/Widgets/modal_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}


class MyApp extends StatelessWidget {

  
  @override



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      theme: ThemeData(
        primarySwatch: Colors.red,
     
      ),
      home:  MyHomePage(title: 'CyForge- forensics report generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {    
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
   MyHomePage({Key? key,required this.title, this.user }) : super(key: key);
 final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

Future<void> _getCurrentUser() async {
    final User? currentUser = widget._auth.currentUser;
    setState(() {
      widget.user = currentUser;
    });
  }
  Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}

   void initState() {
    super.initState();
    _getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
backgroundColor:Colors.blueAccent
 ,     body: Container(
    
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
  Image.asset('assets/images/cyforge.png'),Row(
    mainAxisAlignment:MainAxisAlignment.center ,
    
    
    children: [ElevatedButton( child: Text("Generate Report", style: TextStyle(fontSize: 20,),) ,onPressed: () {
   
      if(widget.user!=null)
    {
       Navigator.push(
                      context,
                      CupertinoPageRoute(
                         builder: (_) => documentType()));
   
          // imagePickerModal(context,  onGalleryTap: () {
          //   log("Gallery");
          //   pickImage(source: ImageSource.gallery).then((value) {
          //     if (value != '') {
          //       imageCropperView(value, context).then((value) {
          //         if (value != '') {
                    
          //           Navigator.push(
          //             context,
          //             CupertinoPageRoute(
          //               builder: (_) => backend(
          //                 path: value,
          //               ),
          //             ),
          //           );
          //         }
          //       });
          //     }
          //   });
          // });
    }else{
      showCupertinoModalPopup(context: context, builder: (context){return AlertDialog(title: Text("Error"),content: Text("Before generating report please ensure you have signed in or created A account and agreed to the terms of service"),);});
    }
        },) ,
        SizedBox(width:10),
ElevatedButton( child: Text("View Reports", style: TextStyle(fontSize: 20),) ,onPressed: (() => {log("View Reports"),
if(widget.user!=null){

}
else{

  showCupertinoModalPopup(context: context, builder: (context){return AlertDialog(title: Text("Error"),content: Text("Before generating report please ensure you have signed in or created A account and agreed to the terms of service"),);})
}







}))

      ],),      

         Padding(
           padding: const EdgeInsets.only(top:10.0),
           child: Row( mainAxisAlignment: MainAxisAlignment.center,
             children: [ 
              
               Align(
                alignment: Alignment.center,
                 child:
                 
                 widget.user == null ?
                 
                 TextButton(   child: Container(decoration:BoxDecoration(borderRadius:BorderRadius.circular(10), color: Color.fromARGB(172, 235, 12, 205)) ,child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Haven't signed in yet? Sign in here", style: TextStyle(  fontSize: 15,color:Color.fromARGB(255, 255, 255, 255)),),
                 )),             onPressed: () {
               
               
                       Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => LoginScreen()
                        ),
                      );
                  }
                    ) : Column(
                      children: [Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Color.fromARGB(172, 65, 248, 80),
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text("Signed in as ${widget.user!.email ?? "Sign in again?"}"),
  ),
),
ElevatedButton(
  onPressed: () async {
    await widget._auth.signOut();
    setState(() {
        widget.user = null;
    });
  },
  child: Text('Sign Out'),
)
                      ],
                    )
               ),
             ],
           ),
         ),
          ]
        ),
        
      ),

    );
  }
}
