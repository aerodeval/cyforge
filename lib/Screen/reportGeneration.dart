
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import '../Utils/backend.dart';
import '../Utils/image_cropper_page.dart';
import '../Utils/image_picker_class.dart';
import '../Widgets/modal_dialog.dart';




class reportGeneration extends StatefulWidget {
 final ImagePicker _picker = ImagePicker();
 List<XFile>? _imageFileList;
 final List<String> selectedUtilities;


   reportGeneration({required this.selectedUtilities});
  @override
  State<reportGeneration> createState() => _reportGenerationState();
}

class _reportGenerationState extends State<reportGeneration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Utilities'),
      ),
      body: ListView.builder(
        itemCount: widget.selectedUtilities.length,
        itemBuilder: (context, index) {
         if(widget.selectedUtilities.isNotEmpty){ return
          
            
           Column(
             children: [Text("data"),
               ListTile(
                title: Text(widget.selectedUtilities[index]),
                tileColor:widget._imageFileList != null ? Colors.green : Colors.red,
                onTap: () {
                  if(widget.selectedUtilities[index]=='Image'){
                 


 imagePickerModal(context,  onGalleryTap: () async {
 log("Gallery");
 try {
          final List<XFile> ?pickedFileList = await widget._picker.pickMultiImage(
        
          );
          setState(() {
               widget._imageFileList = pickedFileList;
          });
        } catch (e) {
          setState(() {
                
          });
        }
                  
                    });
                  }
                },
          ),
             ],
           );
        }
        else {
           return Container(
          decoration: BoxDecoration(color: Colors.amberAccent),
          child: Text("Please select a utility")
        );
         }
        
        }
      ),
    );
  }
}


