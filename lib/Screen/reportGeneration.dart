
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../Utils/backend.dart';
import '../Utils/image_cropper_page.dart';
import '../Utils/image_picker_class.dart';
import '../Widgets/modal_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';




class reportGeneration extends StatefulWidget {
 final ImagePicker _picker = ImagePicker();
 List<XFile>? _imageFileList;
 File? audiofile;
 final List<String> selectedUtilities;
 String? _recognizedText;
 final String controller_sender;
 final String controller_receiver;
 String? stateofop;


   reportGeneration({required this.selectedUtilities, required this.controller_sender, required this.controller_receiver,});
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
        itemBuilder: (context, index) { List data=[widget._imageFileList,widget._recognizedText,widget.stateofop];// find fix for this
         if(widget.selectedUtilities.isNotEmpty){ return
          
            
           Column(
             children: [
              
             
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ListTile(
                  isThreeLine: true,
                  title: Text(widget.selectedUtilities[index]),
                  tileColor:data[index] != null ? Colors.green : Colors.red ,
                 subtitle: Column(  
                    children: [if(widget.selectedUtilities[index]=="Image")...[
                      Container( child: widget._imageFileList!=null ? Container(height: 100,
                    child: GridView.builder(
                                 gridDelegate:
                       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                 itemCount: widget._imageFileList?.length,
                                 itemBuilder: (BuildContext context, int index) {
                     return Image.file(File(widget._imageFileList![index].path) );
                                 },
                               ),
                  ) : Text("No Images Selected"),)
                    ] else if(widget.selectedUtilities[index]=="Audio")...[
                      widget.audiofile==null ? Text("No audio file selected") : Text(basename(widget.audiofile!.path))
  ,
  
  if(widget._recognizedText!= null)...[Text(widget._recognizedText!)]
                    ]

                    else if(widget.selectedUtilities[index]=='Chats')...[

                    Row(mainAxisAlignment:MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Column(
                        children: [ Text("Sender Message"),
                          Container(width:120,child: Text(style:( TextStyle(fontSize: 11,) ),widget.controller_sender),),
                        ],
                      ),Container(color:Color.fromARGB(86, 64, 65, 64) ,height: 110,width: 1,),Column(
                        children: [Text("Receiver Message"),
                          Container(child: Text(style:( TextStyle(fontSize: 11,) ),widget.controller_receiver),),
                        ],
                      )],)

                    ]
                      
                    ],                  
                  ),
                  onTap: () async {      
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
               
               else if(widget.selectedUtilities[index]=='Audio'){
               
        
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['wav'],
    );
    if (result != null) {
    setState(() {
       widget.audiofile = File(result.files.single.path!);
    });
     
      recognize(result);
      
    }
               }
               else if(widget.selectedUtilities[index]=='Chats'){
            widget.stateofop="";
                   
                          imagePickerModal(context,  onGalleryTap: () {
                            
                  log("Gallery");
                  pickImage(source: ImageSource.gallery).then((value) {
                    if (value != '') {

                      imageCropperView(value, context).then((value) {
                        if (value != '') {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                               builder: (_) => backend(path: value,selectedUtilities:widget.selectedUtilities)
                              
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
               }
                    
                  },
                         ),
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
  
  void recognize(FilePickerResult wavFile) async {

  try {
     widget._recognizedText= await convertWavFile(wavFile);
  } catch (e) {
    print('Error converting WAV file: $e');
  }
  
  setState(() {}); 
}

}

Future<String> convertWavFile(FilePickerResult wavFile) async {
  var request = http.MultipartRequest('POST', Uri.parse('http://192.168.0.109:5000/convert'));
  var file = await http.MultipartFile.fromPath('file', wavFile.files.single.path.toString());
  request.files.add(file);
  var response = await request.send();

  
  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    var json = jsonDecode(responseBody);
    var text = json['text'];
    
    return text;
  } else {
    throw Exception('Failed to convert WAV file.');
  }

  
}


