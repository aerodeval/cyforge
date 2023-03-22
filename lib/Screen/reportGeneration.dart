
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
 List<XFile> imageFileList;
 File? audiofile;
 final List<String> selectedUtilities;
 String recognizedText;
 final String controller_sender;
 final String controller_receiver;
 File? _csvFile;
Map<String, dynamic>? chatProcessed;



   reportGeneration({required this.selectedUtilities, required this.controller_sender, required this.controller_receiver, required this.imageFileList, required this.recognizedText, this.chatProcessed});
  @override
  State<reportGeneration> createState() => _reportGenerationState();
}

class _reportGenerationState extends State<reportGeneration> {
 Future<void> _pickCsvFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (result != null) {
      setState(() {
        widget._csvFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _sendCsvFile() async {
    if (widget._csvFile == null) {
      return;
    }
    final url = 'http://192.168.0.109:5000/process_chat';
    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..files.add(await http.MultipartFile.fromPath('csv_file', widget._csvFile!.path));
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final processedData = jsonDecode(responseBody);
    // do something with the processed chat data
  }



  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Utilities'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              
              itemCount: widget.selectedUtilities.length,
              itemBuilder: (context, index) { 
            
      Map<String, dynamic> data = {
        'Image': widget.imageFileList.isEmpty,
        'Audio': widget.recognizedText.isEmpty,
        'Chats': widget.controller_sender=="No data",
        'Text':widget.chatProcessed!.isEmpty
      };
      
      
         
            // find fix for this
               if(widget.selectedUtilities.isNotEmpty){ return
                
                  
                 Column(
                   children: [
                    
                   
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ListTile(
                        isThreeLine: true,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.selectedUtilities[index]),
                        ),
                        tileColor: data[widget.selectedUtilities[index]]== true ? Colors.red : Colors.green          ,subtitle: 
                        
                           Column(  
                              children: [if(widget.selectedUtilities[index]=="Image")...[
                                Container(height: 100, child: widget.imageFileList.isEmpty ?  Align(alignment: Alignment.center, child: Text("No Images Selected")): SizedBox(height: 100,
                              child: GridView.builder(
                                           gridDelegate:
                                 SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                           itemCount: widget.imageFileList.length,
                                           itemBuilder: (BuildContext context, int index) {
                               return Image.file(File(widget.imageFileList[index].path) );
                                           },
                                         ),
                            ) )
                              ] else if(widget.selectedUtilities[index]=="Audio")...[
                                widget.audiofile==null ? Text("No audio file selected") : Text("Transcribed Audio",style: TextStyle(fontWeight: FontWeight.bold),)
        ,
        
        if(widget.recognizedText!= null)...[Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(widget.recognizedText),
        )]
                              ]
      
                              else if(widget.selectedUtilities[index]=='Chats')...[
      
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(mainAxisAlignment:MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Column(
                                    children: [ 
                                     
                                     Container(decoration: BoxDecoration(borderRadius:  BorderRadius.circular(10),color:Color.fromARGB(255, 235, 252, 4)),   child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Sender Message"),
                                     )),
                                    
                                      Container(width:150,child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(textAlign:TextAlign.center, style:( TextStyle(fontSize: 11,) ),widget.controller_sender),
                                      ),),
                                    ],
                                  ),Container(color:Color.fromARGB(84, 196, 199, 196) ,height: 150,width: 1,),Column(
                                    children: [
                                   
                                      Container(decoration: BoxDecoration(borderRadius:  BorderRadius.circular(10),color:Color.fromARGB(255, 235, 252, 4)),child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Receiver Message"),
                                      )),
                                    
                                      Container(width:150,child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(textAlign:TextAlign.center,style:( TextStyle(fontSize: 11,) ),widget.controller_receiver),
                                      ),),
                                    ],
                                  )],),
                              )
      
                              ]
                               

                                else if(widget.selectedUtilities[index]=='Text')...[

                                    Container(  height:50,child:                                   widget.chatProcessed!.isEmpty ? Text("No text processed") : Text("Text processing succesful",style: TextStyle(fontWeight: FontWeight.bold),)
,)
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
                       widget.imageFileList = pickedFileList!;
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
                    
                                imagePickerModal(context,  onGalleryTap: () {
                    
                        log("Gallery");
                        pickImage(source: ImageSource.gallery).then((value) {
                          if (value != '') {
      
                            imageCropperView(value, context).then((value) {
                                                    Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                     builder: (_) => backend(path: value,selectedUtilities:widget.selectedUtilities,imageFileList:widget.imageFileList,recognizedText: widget.recognizedText,chatProcessed:widget.chatProcessed )));
                            });
                          }
                        });
                      
                       
                    
       
                             
                      });
                     }else if(widget.selectedUtilities[index]=='Text'){

  final file = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['txt'],
  );

  // Send the file to the server and print the response
  final response = await processTxtFile(file!);
  setState(() {
    widget.chatProcessed=response;
  });
  print(response);

                         
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
            ),  ElevatedButton.icon(onPressed: (){
              print(widget.chatProcessed);

            }, icon: Icon(Icons.arrow_forward), label:Text("Generate"))
          ],
        ),
      ),
    );
  }
  
  void recognize(FilePickerResult wavFile) async {

  try {
     widget.recognizedText= await convertWavFile(wavFile);
  } catch (e) {
    print('Error converting WAV file: $e');
  }
  
  setState(() {}); 
}

}


Future<Map<String, dynamic>> processTxtFile(FilePickerResult file) async {
  // Get the picked file
  final path = file.files.single.path!;
  final fileBytes = File(path).readAsBytesSync();

  // Set up the request
  final request = http.MultipartRequest(
    'POST',
    Uri.parse('http://192.168.0.109:5000/text'),
  );

  // Add the file to the request
  request.files.add(
    http.MultipartFile.fromBytes(
      'file',
      fileBytes,
      filename: file.files.single.name,
    ),
  );

  // Send the request and receive the response
  final response = await request.send();

  // Read the response as a JSON object
  final responseBody = await response.stream.bytesToString();
  final responseJson = json.decode(responseBody);

  return responseJson;
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


