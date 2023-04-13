import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatelessWidget {
  final String wordlink;
  final String filename;

  QrCodeScreen({required this.wordlink,required this.filename});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: Center(
        child: 
          Column( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(filename),
              Container(
            child: QrImage(
              data: wordlink,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
            ],
          ),
          
        
      ),
    );
  }
}