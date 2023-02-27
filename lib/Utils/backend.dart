import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ocr/Screen/recognization_page.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ocr/Utils/testDisplay.dart';

class backend extends StatefulWidget {
  final String path;
  const backend({Key? key, required this.path}) : super(key: key);
  @override
  State<backend> createState() => _backendState();
}

class _backendState extends State<backend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Selected Cropped Image",
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
                width: double.infinity,
                height: 300,
                child: Container(
                  
                  child: Image.file(File(widget.path)))),
            SizedBox(
              height: 20,
            ),
            Text("Send for processing", style: TextStyle(fontSize: 20)),
            ElevatedButton(
                onPressed: () {
                  sendImageToFlask(widget.path).then((value) {
                    if (value != '') {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => testDisplay(
                            imageBytesList: value,
                          ),
                        ),
                      );
                    }
                  }, onError: (e) {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text(e.toString()),
                          );
                        });
                  });
                },
                child: Text("Process"))
          ]),
    );
  }
}

Future sendImageToFlask(String imageFile) async {
  final response = await http.post(
    Uri.parse("http://192.168.0.109:5000/process-image"),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'image': base64Encode(File(imageFile).readAsBytesSync()),
    }),
  );

  if (response.statusCode == 200) {
    var result = base64Decode(jsonDecode(response.body)['image']);
    var result_recv = base64Decode(jsonDecode(response.body)['image_recv']);
    List<Uint8List> processed_img = [result, result_recv];

    return processed_img;
    // saveImageToGallery(result);

  } else {
    throw Exception('Failed to process image');
  }
}
