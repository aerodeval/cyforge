import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'package:dart_sentiment/dart_sentiment.dart';
import 'package:file_picker/file_picker.dart';  
import 'package:flutter/services.dart';


final sent = new Sentiment();

Future txtProcess({sourcefile}) async {
  // Load the input text file
  final file = File(sourcefile);

  final lines = await file.readAsLines();
  
  // Regular expression pattern to extract the sender name, timestamp, and message content
  final pattern = RegExp(r'(\d{2}\/\d{2}\/\d{4}),\s(\d{1,2}:\d{2}\s[apm]+)\s-\s([\w\s]+):\s(.*)');

  // Dictionary to store the extracted data
  final data = {};

  // Loop over each line
  for (final line in lines) {
    final match = pattern.firstMatch(line);
    if (match != null) {
      final sender = match.group(3);
      final timestamp = match.group(1)! + ', ' + match.group(2).toString();
      final message = match.group(4);



      
    // Clean the message content
      
     String cleanedMessage = message!
          .toLowerCase()
          .replaceAll(RegExp(r'[^\w\s]+'), '');
      


      // Perform sentiment analysis
      if(cleanedMessage==''){
        cleanedMessage="emoji";
      }
      final sentiment = sentimentAnalysis(cleanedMessage);

      // Store the extracted data
      if (data[sender] == null) {
        data[sender] = [];
      }
      data[sender].add({
        'timestamp': timestamp,
        'message': message,
        'sentiment': sentiment,
      });
    }
  }

  // Output the extracted data
  print(json.encode(data));
}

 sentimentAnalysis(String text)  {
final result = sent.analysis(text);
print(result);
  return result['sentiment'];
}
