import 'dart:io';

import 'package:flutter/material.dart';


class TermsOfServiceScreen extends StatefulWidget {
  @override
  _TermsOfServiceScreenState createState() => _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Text('Terms of Service'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                text: 'By checking this box, you agree to our ',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Terms of Service and Data Protection Policy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: '.',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Text("By submitting a cybercrime report, you acknowledge and agree that the information contained in the report is sensitive and confidential. You agree to take all necessary measures to ensure the security and confidentiality of the report, including but not limited to, implementing appropriate technical and organizational security measures to prevent unauthorized access, disclosure, or misuse of the information.You further agree to only share the contents of the report with authorized individuals, such as law enforcement officials or legal professionals, as required by law or court order. You shall not share the contents of the report with any other parties without prior written consent from the reporting party.In the event of a breach of the report's security or confidentiality, you agree to promptly notify the reporting party and take all necessary steps to mitigate the damage caused by the breach.By submitting a cybercrime report, you acknowledge and agree to the terms of this agreement and to comply with all applicable laws and regulations related to the handling of sensitive information.")
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CheckboxListTile(
              title: Text('I agree to the terms of service'),
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}