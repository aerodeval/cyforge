import 'dart:developer';

import 'dart:ui';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:ocr/Screen/SignInPage.dart';
import 'package:ocr/Screen/TermsOfServiceScreen.dart';

import 'package:ocr/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class stepper extends StatefulWidget {
  const stepper({super.key});

  @override
  State<stepper> createState() => _stepperState();
}

class _stepperState extends State<stepper> {


  
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  int currentStep = 0;
    String showYear = 'Select Year';
  DateTime _selectedYear = DateTime.now();
  // our form key
  final _formKey = GlobalKey<FormState>();
  PlatformFile? pickedFile;
  PlatformFile? pickedpdf;
  String mySelectedDb = "Student";

  // editing Controller
  final firstNameEditingController = new TextEditingController();
   final driveLinkEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final phonenoEditingController = new TextEditingController();
  final cehNumberEditingController = new TextEditingController();
  final organizationNameEditingController = new TextEditingController();
  final uidName = new TextEditingController();
  callback(selectedVar) {
    setState(() {
      mySelectedDb = selectedVar;
    });
  }


  @override
  Widget build(BuildContext context) {


    

     final driveLinkField = TextFormField(
        autofocus: false,
        controller: driveLinkEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{5,}$');
          if (value!.isEmpty) {
            return ("Please upload a valid Link");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          driveLinkEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.link),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Certification Proof",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

      final organizationNameField = TextFormField(
        autofocus: false,
        controller: organizationNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{5,}$');
          if (value!.isEmpty) {
            return ("Enter a Valid Names");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          driveLinkEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.work),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Organization Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));


    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Full Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
 final cehNumberField = TextFormField(
        autofocus: false,
        controller: cehNumberEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Identification number cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid data(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Identification Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

   
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final phonenumber = TextFormField(
        autofocus: false,
        controller: phonenoEditingController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          // if (value!.isEmpty) {
          //   return ("Please Enter a Valid phone number");
          // }
          // // reg expression for email validation
          // if (!RegExp("((\+*)((0[ -]*)*|((91 )*))((\d{12})+|(\d{10})+))|\d{5}([- ]*)\d{6}")
          //     .hasMatch(value)) {
          //   return ("Please Enter a valid phone number");
          // }
          // return null;

          if (value!.length == 0 || value.length < 6) {
            return ("Please enter Valid 10-digit number");
          } else if (value.length > 10) {
            return ("Please enter Valid 10-digit number");
          }
          return null;
        },
        onSaved: (value) {
          phonenoEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone_android),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
 


 List<Step> getSteps() => [
        Step(
            isActive: currentStep >= 0,
            title: Text("Step 1"),
            content: Container(
                child: SingleChildScrollView(child:  Container(
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        child:
                            Text("User Account registration", style: TextStyle(fontSize: 20))),
                    SizedBox(height: 5),
                
         
 
                    SizedBox(height: 4),
                    SizedBox(height: 4),
                    emailField,
                    SizedBox(height: 14),
                 
                 
                    passwordField,
                    SizedBox(height: 14),
                    confirmPasswordField,
                 SizedBox(height: 14),
                 
                    cehNumberField, SizedBox(height: 14),
                    Container( decoration: BoxDecoration(borderRadius:BorderRadius.circular(10) , color: Color.fromARGB(255, 33, 139, 131)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(style:TextStyle(fontWeight:FontWeight.bold,fontSize: 15,color: Colors.white),  textAlign: TextAlign.center,"Your account will contain all your previously generated reports which can be accessed through the app"),
                      ),
                    )

                  ],
                ),
              ),
            ),
          )))),
        Step(
            isActive: currentStep >= 1,
            title: Text("Step 2"),
            content: Container(
               width: 390,
               height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form( 
                  child: Column( 
                     mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
              
                    children: [
                      Container(decoration: BoxDecoration(borderRadius:BorderRadius.circular(10) , color: Color.fromARGB(255, 245, 63, 72)),child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(style:TextStyle(fontWeight:FontWeight.bold,fontSize: 15,color: Colors.white),  textAlign: TextAlign.center,"Some personal details are required for verification please proceed with legit information"),
                      ) ,)
                     ,SizedBox(height: 20,),
                     firstNameField,
                     SizedBox(height:10),   
                     phonenumber,
                     SizedBox(height:10),
                     Text(style:TextStyle(fontSize: 20),"Please upload proof of Certification(file link)"),
                     SizedBox(height:10),
                     driveLinkField,SizedBox(height:10),
                     Row(
                      
                      crossAxisAlignment: CrossAxisAlignment.center,
                      
                      children: [  Text(style:TextStyle(fontSize: 20),"Name of organization"),SizedBox(width: 10,),Tooltip(child: Icon(Icons.info),message: "If you are a Solo Practioner type Solo",   waitDuration: Duration(seconds: 1),  
                  showDuration: Duration(seconds: 2),  )],),  
                    
SizedBox(height:10),

                    
                    SizedBox(height: 2,),organizationNameField                     
                
                    ],

                  ),
                ),
              ),
            )),
 Step(
            isActive: currentStep >= 2,
            title: Text("Step 3"),
            content: Container(
               width: 350,
               height: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
              child: Column(

                children: [
                    Expanded(child: TermsOfServiceScreen())
                ],
              ),
              
            )),


      ];

      




      
    return Scaffold(
      
      body: Container(
        color: Color.fromARGB(176, 99, 8, 184),
        child: Stepper(

          
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepTapped: (step) => setState(() => currentStep = step),
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;

            if (isLastStep) {
             submit();
            } else {
              setState((() => currentStep += 1));
            }
          },
          onStepCancel: () =>
              {currentStep == 0 ? Navigator.pop(context) : setState((() => currentStep -= 1))},
          controlsBuilder: (context, details) {
            return Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
              children: [
                  Expanded(
                      child: ElevatedButton(style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              fixedSize: const Size(40, 40),
              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
                          onPressed: details.onStepContinue,
                          child: Text("Next"))),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton( style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              fixedSize: const Size(40, 40),
              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
                          onPressed: details.onStepCancel, child: Text("Back")))
              ],
            ),
                ));
          },
        ),
      ),
    );
  }


     void submit() {
  
       signUp(emailEditingController.text, passwordEditingController.text);
   
    }
    void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
    else{
  Fluttertoast.showToast(msg:"Please check if all fields of form are filled correctly");

    }
  
  }

   postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.firstName = firstNameEditingController.text;
    userModel.password = passwordEditingController.text;
    userModel.pno = phonenoEditingController.text;
    userModel.cehNumber=cehNumberEditingController.text;
    userModel.organization=organizationNameEditingController.text;
    userModel.clink=driveLinkEditingController.text;
  

    // userModel.pdf=pickedpdf.toString();
    // userModel.pic=pickedFile.toString();
    // final path ='users/${user.uid}';
    // final profilepic=File(pickedFile!.path!);
    // final pdfile=File(pickedpdf!.path!);
    // final ref = FirebaseStorage.instance.ref().child(path);
    // ref.putFile(profilepic);
    // ref.putFile(pdfile);




    await firebaseFirestore
        .collection("users")
        .doc(firstNameEditingController.text)
        .set(userModel.toMap());
    Fluttertoast.showToast(
        msg: "Account created successfully, Please contact admin ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
}

 

