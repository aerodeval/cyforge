import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:ocr/Screen/recognization_page.dart';


class testDisplay extends StatefulWidget {
  final List<Uint8List> ?imageBytesList;

  testDisplay({Key? key, @required this.imageBytesList}) : super(key: key);

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
                        builder: (_) => RecognizePage(imageBytesList: widget.imageBytesList),
                      ),
                    );
            }) , child: Text("peform ocr"))
          ],
        ),
      ),
    );
  }
}
