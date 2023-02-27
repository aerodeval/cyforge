import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ocr/Utils/backend.dart';
import 'package:ocr/Utils/image_cropper_page.dart';
import 'package:ocr/Utils/image_picker_class.dart';
import 'package:ocr/Utils/txtProcess.dart';
import 'package:ocr/Widgets/modal_dialog.dart';
import 'package:ocr/Screen/recognization_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';


  Future pickFile() async {

 FilePickerResult ?filePath = await  FilePicker.platform.pickFiles();
if (filePath != null) {
 return filePath.files.single.path;
} else {
  // Handle the case where the file picker returns a null file path
}
  // User canceled the picker

}
class documentType extends StatelessWidget {
  
  const documentType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Choose type of evidence'),
      ),
      body: Container(decoration: BoxDecoration(color: Colors.greenAccent),
        child: Row( 
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                
                      imagePickerModal(context,  onGalleryTap: () {
              log("Gallery");
              pickImage(source: ImageSource.gallery).then((value) {
                if (value != '') {

                  imageCropperView(value, context).then((value) {
                    if (value != '') {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                           builder: (_) => backend(path: value,)
                          
                          // RecognizePage(
                          //   path: value,
                          // ),
                        ),
                      );
                    }
                  });
                }
              });
            });
                    
         
                },
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children:  [Text("Gallery",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 40)),
                
                 SizedBox( width: 150,height: 240,
                        child:Image(fit: BoxFit.fitWidth, image: AssetImage(
                                  'assets/images/gallery.png')) 
                            
                            
                       
                      
                      ),
               
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  filePickerModal(context,  onGalleryTap: () {
              log("CSV");
             pickFile().then((value) {
                if (value != '') {txtProcess(sourcefile: value);
                  // imageCropperView(value, context).then((value) {
                  //   if (value != '') {
                  //     Navigator.push(
                  //       context,
                  //       CupertinoPageRoute(
                  //          builder: (_) => backend(path: value,)
                  //         // RecognizePage(
                  //         //   path: value,
                  //         // ),
                  //       ),
                  //     );
                  //   }
                  // });
                }
              });
            });
                },
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Text("CSV File",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 40)),
                    SizedBox( width: 150,height: 250,
                      child: Image( image: AssetImage(
                                'assets/images/csv.png')) 
                          
                          
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


    