// import 'dart:ui';


// import 'package:flutter/material.dart';










// class dropDown extends StatefulWidget {
//   final Function? callback;

//   dropDown({this.callback});

//   @override
//   State<dropDown> createState() => _dropDownState();
// }

// class _dropDownState extends State<dropDown> {
//   String? tempval;

//   String dropdownValue = "Student"; //access the value selected from this widget
//   sendsvalue() {
//     print(tempval);
//     return tempval as String;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 11,
//       style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
//       onChanged: (String? newValue) {
//         setState(() {
//           dropdownValue = newValue!;
//           print(newValue);
//           tempval = newValue;
//           print(tempval);

//           widget.callback!(tempval);
//         });
//       },
//       items: <String>[
//        'Student','Faculty','Alumini'
//       ].map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }




// // class RegistrationScreen extends StatefulWidget {
// //   const RegistrationScreen({Key? key}) : super(key: key);

// //   @override
// //   _RegistrationScreenState createState() => _RegistrationScreenState();
// // }

// // class _RegistrationScreenState extends State<RegistrationScreen> {
// //   final _auth = FirebaseAuth.instance;

// //   // string for displaying the error Message
// //   String? errorMessage;

// //   // our form key
// //   final _formKey = GlobalKey<FormState>();
// //   String mySelectedDb = "Student";
// //    String mySelectedbranch = "Rambaug (Kalyan)";
// //   // editing Controller
// //   final firstNameEditingController = new TextEditingController();
// //   final secondNameEditingController = new TextEditingController();
// //   final emailEditingController = new TextEditingController();
// //   final passwordEditingController = new TextEditingController();
// //   final confirmPasswordEditingController = new TextEditingController();
// //   final phonenoEditingController = new TextEditingController();
// //   final branchName = new TextEditingController();
// //   final uidName = new TextEditingController();
// //   callback(selectedVar) {
// //     setState(() {
// //       mySelectedDb = selectedVar;
// //     });
// //   }

 



// //   @override
// //   Widget build(BuildContext context) {
// //     //first name field
// //     final firstNameField = TextFormField(
// //         autofocus: false,
// //         controller: firstNameEditingController,
// //         keyboardType: TextInputType.name,
// //         validator: (value) {
// //           RegExp regex = new RegExp(r'^.{3,}$');
// //           if (value!.isEmpty) {
// //             return ("First Name cannot be Empty");
// //           }
// //           if (!regex.hasMatch(value)) {
// //             return ("Enter Valid name(Min. 3 Character)");
// //           }
// //           return null;
// //         },
// //         onSaved: (value) {
// //           firstNameEditingController.text = value!;
// //         },
// //         textInputAction: TextInputAction.next,
// //         decoration: InputDecoration(
// //           prefixIcon: Icon(Icons.account_circle),
// //           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
// //           hintText: "Full Name",
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //         ));

// //     void submit() {

// //        signUp(emailEditingController.text, passwordEditingController.text);
// //     }

// //     //email field
// //     final emailField = TextFormField(
// //         autofocus: false,
// //         controller: emailEditingController,
// //         keyboardType: TextInputType.emailAddress,
// //         validator: (value) {
// //           if (value!.isEmpty) {
// //             return ("Please Enter Your Email");
// //           }
// //           // reg expression for email validation
// //           if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
// //               .hasMatch(value)) {
// //             return ("Please Enter a valid email");
// //           }
// //           return null;
// //         },
// //         onSaved: (value) {
// //           firstNameEditingController.text = value!;
// //         },
// //         textInputAction: TextInputAction.next,
// //         decoration: InputDecoration(
// //           prefixIcon: Icon(Icons.mail),
// //           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
// //           hintText: "Email",
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //         ));

// //     final passwordField = TextFormField(
// //         autofocus: false,
// //         controller: passwordEditingController,
// //         obscureText: true,
// //         validator: (value) {
// //           RegExp regex = new RegExp(r'^.{6,}$');
// //           if (value!.isEmpty) {
// //             return ("Password is required for login");
// //           }
// //           if (!regex.hasMatch(value)) {
// //             return ("Enter Valid Password(Min. 6 Character)");
// //           }
// //         },
// //         onSaved: (value) {
// //           firstNameEditingController.text = value!;
// //         },
// //         textInputAction: TextInputAction.next,
// //         decoration: InputDecoration(
// //           prefixIcon: Icon(Icons.vpn_key),
// //           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
// //           hintText: "Password",
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //         ));

// //     //confirm password field
// //     final confirmPasswordField = TextFormField(
// //         autofocus: false,
// //         controller: confirmPasswordEditingController,
// //         obscureText: true,
// //         validator: (value) {
// //           if (confirmPasswordEditingController.text !=
// //               passwordEditingController.text) {
// //             return "Password don't match";
// //           }
// //           return null;
// //         },
// //         onSaved: (value) {
// //           confirmPasswordEditingController.text = value!;
// //         },
// //         textInputAction: TextInputAction.done,
// //         decoration: InputDecoration(
// //           prefixIcon: Icon(Icons.vpn_key),
// //           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
// //           hintText: "Confirm Password",
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //         ));
// //     final phonenumber = TextFormField(
// //         autofocus: false,
// //         controller: phonenoEditingController,
// //         keyboardType: TextInputType.phone,
// //         validator: (value) {
// //           // if (value!.isEmpty) {
// //           //   return ("Please Enter a Valid phone number");
// //           // }
// //           // // reg expression for email validation
// //           // if (!RegExp("((\+*)((0[ -]*)*|((91 )*))((\d{12})+|(\d{10})+))|\d{5}([- ]*)\d{6}")
// //           //     .hasMatch(value)) {
// //           //   return ("Please Enter a valid phone number");
// //           // }
// //           // return null;

// //           if (value!.length == 0 || value.length < 6) {
// //             return ("Please enter Valid 10-digit number");
// //           } else if (value.length > 10) {
// //             return ("Please enter Valid 10-digit number");
// //           }
// //           return null;
// //         },
// //         onSaved: (value) {
// //           phonenoEditingController.text = value!;
// //         },
// //         textInputAction: TextInputAction.next,
// //         decoration: InputDecoration(
// //           prefixIcon: Icon(Icons.phone_android),
// //           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
// //           hintText: "Phone Number",
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //         ));
  
// //     //signup button
// //     final signUpButton = Material(

// //       elevation: 5,
// //       borderRadius: BorderRadius.circular(30),
// //       color: Colors.redAccent,
// //       child: MaterialButton(
        
// //           padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
// //           minWidth: MediaQuery.of(context).size.width,
// //           onPressed: () {
// //             submit();

// //             // signUp(emailEditingController.text, passwordEditingController.text);
// //           },
// //           child: Container(
            
// //             child: Text(
// //               "Next",
// //               textAlign: TextAlign.center,
// //               style: TextStyle(
// //                   fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
// //             ),
// //           )),
// //     );

// //     return Container(
// //             width: 350,
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(40),
// //               color: Colors.white,
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.all(36.0),
// //               child: Form(
// //                 key: _formKey,
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: <Widget>[
// //                     Container(
// //                         alignment: Alignment.topLeft,
// //                         child:
// //                             Text("User registration", style: TextStyle(fontSize: 20))),
// //                     SizedBox(height: 5),
                
         
 
// //                     SizedBox(height: 4),
// //                     SizedBox(height: 4),
// //                     emailField,
// //                     SizedBox(height: 14),
                 
                 
// //                     passwordField,
// //                     SizedBox(height: 4),
// //                     confirmPasswordField,
// //                     SizedBox(height: 20),
// //                        Container(
// //                         alignment: Alignment.topLeft,
// //                         child: Text("You are a?",
// //                             style: TextStyle(fontSize: 20))),
// //                     Container(
// //                       child: dropDown(callback: callback),
// //                       width: double.infinity,
// //                     ),
// //                                        firstNameField,
// //                                                   SizedBox(height: 10),
// //                     phonenumber,
// //                     SizedBox(height: 10),
              
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //   }

// //   void signUp(String email, String password) async {
// //     if (_formKey.currentState!.validate()) {
// //       try {
// //         await _auth
// //             .createUserWithEmailAndPassword(email: email, password: password)
// //             .then((value) => {postDetailsToFirestore()})
// //             .catchError((e) {
// //           Fluttertoast.showToast(msg: e!.message);
// //         });
// //       } on FirebaseAuthException catch (error) {
// //         switch (error.code) {
// //           case "invalid-email":
// //             errorMessage = "Your email address appears to be malformed.";
// //             break;
// //           case "wrong-password":
// //             errorMessage = "Your password is wrong.";
// //             break;
// //           case "user-not-found":
// //             errorMessage = "User with this email doesn't exist.";
// //             break;
// //           case "user-disabled":
// //             errorMessage = "User with this email has been disabled.";
// //             break;
// //           case "too-many-requests":
// //             errorMessage = "Too many requests";
// //             break;
// //           case "operation-not-allowed":
// //             errorMessage = "Signing in with Email and Password is not enabled.";
// //             break;
// //           default:
// //             errorMessage = "An undefined Error happened.";
// //         }
// //         Fluttertoast.showToast(msg: errorMessage!);
// //         print(error.code);
// //       }
// //     }
// //   }

// //   postDetailsToFirestore() async {
// //     // calling our firestore
// //     // calling our user model
// //     // sedning these values

// //     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
// //     User? user = _auth.currentUser;

// //     UserModel userModel = UserModel();

// //     // writing all the values
// //     userModel.email = user!.email;
// //     userModel.uid = user.uid;
// //     userModel.firstName = firstNameEditingController.text;
// //     userModel.password = passwordEditingController.text;
// //     userModel.course = mySelectedDb;
// //     userModel.pno = phonenoEditingController.text;
// //     userModel.branch = mySelectedbranch;
// //     userModel.rno = uidName.text;
// //     await firebaseFirestore
// //         .collection("users")
// //         .doc(emailEditingController.text)
// //         .set(userModel.toMap());
// //     Fluttertoast.showToast(
// //         msg: "Account created successfully, Please contact admin ");

// //     Navigator.pushAndRemoveUntil(
// //         (context),
// //         MaterialPageRoute(builder: (context) => MyHomePage()),
// //         (route) => false);
// //   }
// // }

// // enum dbrole { student, teacher }

// // class RadioButton extends StatefulWidget {
// //   final Function? callback;

// //   RadioButton({this.callback});
// //   @override
// //   State<RadioButton> createState() => _RadioButtonState();
// // }

// // class _RadioButtonState extends State<RadioButton> {
// //   String val = "";
// //   dbrole? _role = dbrole.student;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: <Widget>[
// //         ListTile(
// //           title: const Text('Student'),
// //           visualDensity: VisualDensity(vertical: -3),
// //           leading: Radio<dbrole>(
// //             value: dbrole.student,
// //             groupValue: _role,
// //             onChanged: (dbrole? value) {
// //               setState(() {
// //                 _role = value;
// //                 val = "Student";
// //                 widget.callback!(val);
// //               });
// //             },
// //           ),
// //         ),
// //         ListTile(
// //           title: const Text('Teacher'),
// //           visualDensity: VisualDensity(vertical: -3),
// //           leading: Radio<dbrole>(
// //             value: dbrole.teacher,
// //             groupValue: _role,
// //             onChanged: (dbrole? value) {
// //               setState(() {
// //                 _role = value;
// //                 val = "Teacher";
// //                 widget.callback!(val);
// //               });
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
