import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:lottie/lottie.dart';
import 'package:ocr/Utils/View.dart';



class ViewReports extends StatefulWidget {
  final String userEmail;

  ViewReports({required this.userEmail});

  @override
  State<ViewReports> createState() => _ViewReportsState();
}

class _ViewReportsState extends State<ViewReports> {
  late CollectionReference _reportsCollection;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reports'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:   FirebaseFirestore.instance.collection(widget.userEmail).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return Container(alignment: Alignment.center, child: Column(
              children: [
                Container(
                  child: Lottie.asset('assets/lottie/emptyfile.json'),
                  height: 350,
                ),
                Text('It looks empty, To create a report click on generate report'),
              ],
            ));


          }  
final   reports = snapshot.data!.docs;
       
  

          return ListView.builder(

      
            itemCount: reports.length,
            itemBuilder: (context, index) {
                  QueryDocumentSnapshot reportsdata = snapshot.data!.docs[index];
          
              final fileName = reportsdata['fileName'];
              final fileUrl = reportsdata['fileUrl'];

              return InkWell(
                child: Row(
                  children: [
                     Container(
                                          
                                        width: 50.0,
                                        height: 48.0,
                                        decoration: BoxDecoration(
                                          
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/pdf.png'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                    Container(
                       decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 196, 196, 196),
                                              width: 1.0,
                                            ),
                                          ),
                                         
                                        ),
                                          margin: const EdgeInsets.only(
                                              top: 20.0, bottom: 30.0),
                                          
                                            width:250,
                      
                      child: Text(fileName)),
                  ],
                ),
                onTap: () {
                  print(fileUrl);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => View(url: fileUrl),
                    ),
                  );
                },
              );
           
            },
          );
      
       
        },
      ),
    );
  }
}
