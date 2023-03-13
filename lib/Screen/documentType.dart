import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ocr/Screen/reportGeneration.dart';
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


class documentType extends StatefulWidget {
  const documentType({super.key});

  @override
  State<documentType> createState() => _documentTypeState();
}

class _documentTypeState extends State<documentType> {
 List<String> selectedUtilities = [];
  @override
 Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Choose type of evidence'),
      ),
      body: Container(decoration: BoxDecoration(color: Colors.greenAccent),
        child: Column(
          children: [
            Row( 
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                    
                _toggleSelection('Image');
              

                //           imagePickerModal(context,  onGalleryTap: () {
                //   log("Gallery");
                //   pickImage(source: ImageSource.gallery).then((value) {
                //     if (value != '') {

                //       imageCropperView(value, context).then((value) {
                //         if (value != '') {
                //           Navigator.push(
                //             context,
                //             CupertinoPageRoute(
                //                builder: (_) => backend(path: value,)
                              
                //               // RecognizePage(
                //               //   path: value,
                //               // ),
                //             ),
                //           );
                //         }
                //       });
                //     }
                //   });
                // });
                        
             
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container( width:80,height:150,decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              
                                  color:  _isSelected('Image') ? Color.fromARGB(127, 74, 62, 240) : Colors.greenAccent 
                                  
                                  ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children:  [Text("Gallery",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20)),
                        
                         SizedBox( width: 100,height: 100,
                                child:Image(fit: BoxFit.fitWidth, image: AssetImage(
                                          'assets/images/gallery.png')) 
                                    
                                    
                               
                              
                              ),
                                     
                          ],
                        ),
                      ),
                    ),
                  ),
                ),  Expanded(
                  child: GestureDetector(
                    onTap: () {
                    
                _toggleSelection('Chats');
              

                //           imagePickerModal(context,  onGalleryTap: () {
                //   log("Gallery");
                //   pickImage(source: ImageSource.gallery).then((value) {
                //     if (value != '') {

                //       imageCropperView(value, context).then((value) {
                //         if (value != '') {
                //           Navigator.push(
                //             context,
                //             CupertinoPageRoute(
                //                builder: (_) => backend(path: value,)
                              
                //               // RecognizePage(
                //               //   path: value,
                //               // ),
                //             ),
                //           );
                //         }
                //       });
                //     }
                //   });
                // });
                        
             
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container( width:80,height:150,decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              
                                  color:  _isSelected('Chats') ? Color.fromARGB(127, 74, 62, 240) : Colors.greenAccent 
                                  
                                  ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children:  [Text("Chats",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20)),
                        
                         SizedBox( width: 100,height: 100,
                                child:Image(fit: BoxFit.fitWidth, image: AssetImage(
                                          'assets/images/chat.png')) 
                                    
                                    
                               
                              
                              ),
                                     
                          ],
                        ),
                      ),
                    ),
                  ),
                 ),
                // Expanded(
                //   child: GestureDetector(
                //     onTap: () {
                //       filePickerModal(context,  onGalleryTap: () {
                //   log("CSV");
                //  pickFile().then((value) {
                //     if (value != '') {txtProcess(sourcefile: value);
                //       // imageCropperView(value, context).then((value) {
                //       //   if (value != '') {
                //       //     Navigator.push(
                //       //       context,
                //       //       CupertinoPageRoute(
                //       //          builder: (_) => backend(path: value,)
                //       //         // RecognizePage(
                //       //         //   path: value,
                //       //         // ),
                //       //       ),
                //       //     );
                //       //   }
                //       // });
                //     }
                //   });
                // });
                //     },
                //     child: Column(mainAxisAlignment: MainAxisAlignment.center,
                //       children: [ Text("CSV File",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 40)),
                //         SizedBox( width: 150,height: 250,
                //           child: Image( image: AssetImage(
                //                     'assets/images/csv.png')) 
                              
                              
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                    
                _toggleSelection('Audio');
          

                //           imagePickerModal(context,  onGalleryTap: () {
                //   log("Gallery");
                //   pickImage(source: ImageSource.gallery).then((value) {
                //     if (value != '') {

                //       imageCropperView(value, context).then((value) {
                //         if (value != '') {
                //           Navigator.push(
                //             context,
                //             CupertinoPageRoute(
                //                builder: (_) => backend(path: value,)
                              
                //               // RecognizePage(
                //               //   path: value,
                //               // ),
                //             ),
                //           );
                //         }
                //       });
                //     }
                //   });
                // });
                        
         
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container( width:80,height:150,decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                               
                                  color:  _isSelected('Audio') ?Color.fromARGB(127, 74, 62, 240) : Colors.greenAccent 
                                  
                                  ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children:  [Text("Audio",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20)),
                        
                         SizedBox( width: 100,height: 100,
                                child:Image(fit: BoxFit.fitWidth, image: AssetImage(
                                          'assets/images/audio.png')) 
                                    
                                    
                               
                              
                              ),
                                     
                          ],
                        ),
                      ),
                    ),
                  ),
                 ),Expanded(
                  child: GestureDetector(
                    onTap: () {
                    
                _toggleSelection('CSV');
          

                //           imagePickerModal(context,  onGalleryTap: () {
                //   log("Gallery");
                //   pickImage(source: ImageSource.gallery).then((value) {
                //     if (value != '') {

                //       imageCropperView(value, context).then((value) {
                //         if (value != '') {
                //           Navigator.push(
                //             context,
                //             CupertinoPageRoute(
                //                builder: (_) => backend(path: value,)
                              
                //               // RecognizePage(
                //               //   path: value,
                //               // ),
                //             ),
                //           );
                //         }
                //       });
                //     }
                //   });
                // });
                        
         
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container( width:80,height:150,decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                               
                                  color:  _isSelected('CSV') ? Color.fromARGB(127, 74, 62, 240) : Colors.greenAccent 
                                  
                                  ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children:  [Text("CSV",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20)),
                        
                         SizedBox( width: 100,height: 100,
                                child:Image(fit: BoxFit.fitWidth, image: AssetImage(
                                          'assets/images/csv.png')) 
                                    
                                    
                               
                              
                              ),
                                     
                          ],
                        ),
                      ),
                    ),
                  ),
                 ),
              ],
            ),
            Container(decoration:BoxDecoration(color: Colors.amberAccent)  ,child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Other formats of evidences will be introduced soon "),
            ),),
            SizedBox(height: 20),
            ElevatedButton(onPressed: ()=>{ 
              if(selectedUtilities.isNotEmpty){
                   Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => reportGeneration(
                    selectedUtilities: selectedUtilities
                  ),
                ),
              )
              }
              else{ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please select at least one item'),
      ),
    )}
              
              
              
              
           }, child: Text("Start Generating Report"))
          ],
        ),
      ),
    );

  }
  
  void _toggleSelection(String utility) {
  setState(() {
    if (selectedUtilities.contains(utility)) {
      selectedUtilities.remove(utility);
    } else {
      selectedUtilities.add(utility);
    }
  });
}

bool _isSelected(String utility) {
  return selectedUtilities.contains(utility);
}
}
