import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr/Screen/reportGeneration.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;


class RecognizePage extends StatefulWidget {
  final List<Uint8List> ?imageBytesList;
   final List<String> selectedUtilities;
     final String recognizedText;
  final List<XFile> imageFileList;
  final  Map<String, dynamic>? chatProcessed;
  const RecognizePage({Key? key, this.imageBytesList, required this.selectedUtilities, required this.recognizedText, required this.imageFileList, this.chatProcessed}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}  var input_imagesender;
var input_imagereceiver;

Future<File> writeBytesToFile(Uint8List imageBytes, String fileName) async {
  final directory = await getTemporaryDirectory();
  final file = File('${directory.path}/$fileName.png');
  await file.writeAsBytes(imageBytes);
  return file;
}

// Create an InputImage from the stored bytes
Future<InputImage> createInputImageFromBytes(Uint8List imageBytes, String fileName) async {
  final file = await writeBytesToFile(imageBytes, fileName);
  return InputImage.fromFilePath(file.path);
}
class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;

  TextEditingController controller_sender = TextEditingController();
  TextEditingController controller_receiver = TextEditingController();
Future<void> someFunction() async {


InputImage inputImageSender = await createInputImageFromBytes(widget.imageBytesList![0], 'senderImage');
InputImage inputImagereceiver = await createInputImageFromBytes(widget.imageBytesList![1], 'receiverImage');
setState(() {
input_imagesender=inputImageSender;
input_imagereceiver=inputImagereceiver;
});
}
  
  
  @override
  void initState() {
    super.initState();
    if(widget.imageBytesList==null){
 Navigator.pop(context);
}

 someFunction();
   
    processImage(input_imagereceiver);
     processImage(input_imagesender);
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Text Processed")),
        body: _isBusy == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
              children: [
                Container(
                    height: 200,
                    child: TextFormField(
                      maxLines: MediaQuery.of(context).size.height.toInt(),
                      controller: controller_sender,
                      decoration:
                          const InputDecoration(hintText: "Sender Text will appear here"),
                    ),
                  ),
                  Container( height: 200,
                    child: TextFormField(maxLines: MediaQuery.of(context).size.height.toInt(),
                      controller: controller_receiver,
                      decoration:
                          const InputDecoration(hintText: "Receiver text will appear here"),),
                  )
                  ,const Text("Send for report generation"),
                  ElevatedButton(onPressed: (){ Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => reportGeneration(selectedUtilities: widget.selectedUtilities, controller_receiver: controller_receiver.text,controller_sender: controller_sender.text,imageFileList:widget.imageFileList,recognizedText: widget.recognizedText,chatProcessed:widget.chatProcessed),
      ),
    );},child: Text("submit"),)
              ],
            ));
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    log(image.filePath!);

    if (path.basename(image.filePath!)=="senderImage.png"){
      final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    controller_sender.text = recognizedText.text;
if(controller_receiver.text==""){
      controller_receiver.text="Please check image";
    }
    ///End busy state
    setState(() {
      _isBusy = false;
    });}
    else if(path.basename(image.filePath!)=="receiverImage.png"){
final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    controller_receiver.text = recognizedText.text;
    if(controller_receiver.text==""){
      controller_receiver.text="Please check image";
    }

    ///End busy state
    setState(() {
      _isBusy = false;
    });


    }
    
  }
}



