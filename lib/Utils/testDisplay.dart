
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr/Screen/recognization_page.dart';


class testDisplay extends StatefulWidget {
  final List<Uint8List> ?imageBytesList;
   final List<String> selectedUtilities;
  final String recognizedText;
  final List<XFile> imageFileList;
  testDisplay({Key? key, @required this.imageBytesList, required this.selectedUtilities,required this.recognizedText,required this.imageFileList}) : super(key: key);

  @override
  _testDisplayState createState() => _testDisplayState();
}

class _testDisplayState extends State<testDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Display"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.imageBytesList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.memory(
                    widget.imageBytesList![index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            ElevatedButton(onPressed:(() {
                Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => RecognizePage(imageBytesList: widget.imageBytesList,selectedUtilities: widget.selectedUtilities,imageFileList:widget.imageFileList,recognizedText: widget.recognizedText),
                      ),
                    );
            }) , child: Text("peform ocr"))
          ],
        ),
      ),
    );
  }
}
