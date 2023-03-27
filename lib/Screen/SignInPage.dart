
import 'dart:developer';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:ocr/Screen/documentType.dart';
import 'package:ocr/main.dart';
import 'package:provider/provider.dart';
import 'stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';





class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  
    void _passview() {
    if (pass == true) {
      pass = false;
    } else {
      pass = true;
    }
    setState(() {});
  }
  bool pass = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
        color: Color.fromARGB(176, 99, 8, 184),
     
     
        child: Column(children: [
     
      SizedBox(height: 20),
                
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                          alignment: Alignment.topLeft,
                          child: Text("Sign In",
                              style: GoogleFonts.montserrat(
                                  fontSize: 60,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 255, 255, 255)))),
              ),
              
                  SizedBox(height:50),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),   
                    color: Color.fromARGB(255, 255, 255, 255),),
                 
                    child: Column(children: [

                         Image.asset(width: 100,'assets/images/cyforge.png'),
                
                      TextField(

                         
                        controller: emailController,
                        decoration: InputDecoration(
                       
                       
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      TextField(
                        
                      
                        obscureText: pass,
                        controller: passwordController,
                        decoration: InputDecoration(
                          
                            labelText: "Password",
                            prefixIcon: Icon(Icons.security),
                            suffixIcon: InkWell(
                                onTap: _passview, child: Icon(Icons.visibility))),
                      ),
                      Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                             style: ElevatedButton.styleFrom(
     
         primary: Colors.pink ),// backgro
     
                            onPressed: () async{
                           FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value) {showDialog(context: context, builder: (context){return AlertDialog(title: Text("Welcome"),content: Text("Login Succesful"),);});
                          log("login");
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                user: value.user,
                                title:"",
                                
                                    // .split("@")
                                    // .join()
                                    // .split(".in")
                                    // .join()
                                    )));

                  }).onError((error, stackTrace) {showDialog(context: context, builder: (context){return AlertDialog(title: Text("Error in Sign in"),content:Text("${error.toString()
  }"),);});
                    print("Error ${error.toString()}");
                        
     
                            },
                            );  },
                          
                          child: (Text("Sign in")),
                          ),
                      
                                    
       ElevatedButton(
                         style: ElevatedButton.styleFrom(
     
         primary: Colors.pink, ),// backgro
     
                        onPressed: () async{
                       
   
                      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const stepper()),
              );
                        },
                        child: const Text("Register"),
                      ),
     
                      
                        ],
     
     
                        
                      ),
         
     
        ],),
         )]))
    );
  

   

   
                
  }
  
}


