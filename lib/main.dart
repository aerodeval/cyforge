import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr/Screen/recognization_page.dart';
import 'package:ocr/Utils/backend.dart';
import 'package:ocr/Utils/image_cropper_page.dart';
import 'package:ocr/Utils/image_picker_class.dart';
import 'package:ocr/Widgets/modal_dialog.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      theme: ThemeData(
        primarySwatch: Colors.red,
     
      ),
      home: const MyHomePage(title: 'CyForge- forensics report generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
backgroundColor:Colors.blueAccent
 ,     body: Center(
    
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
  Image.asset('assets/images/cyforge.png'),Row(
    mainAxisAlignment:MainAxisAlignment.center ,
    
    
    children: [ElevatedButton( child: Text("Generate Report", style: TextStyle(fontSize: 20),) ,onPressed: () {
          imagePickerModal(context,  onGalleryTap: () {
            log("Gallery");
            pickImage(source: ImageSource.gallery).then((value) {
              if (value != '') {
                imageCropperView(value, context).then((value) {
                  if (value != '') {
                    
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => backend(
                          path: value,
                        ),
                      ),
                    );
                  }
                });
              }
            });
          });
        },) ,
        SizedBox(width:10),
ElevatedButton( child: Text("View Reports", style: TextStyle(fontSize: 20),) ,onPressed: (() => {log("View Reports")}))

      ],)      

          ]
        ),
      ),

    );
  }
}
