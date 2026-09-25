import 'package:course_firebase1/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Fire base"),
      actions: [
        IconButton(onPressed: ()async{
          // GoogleSignIn googleSignIn = GoogleSignIn();
          // googleSignIn.disconnect();
          await FirebaseAuth.instance.signOut();
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
        },
         icon: Icon(Icons.exit_to_app))
      ],),
      body: Padding(
        padding:  EdgeInsets.all(20),
        child:ListView(
  children: [
       Text("Welcome", style: TextStyle(fontSize: 24))
    
    
      // MaterialButton(
      //   color: Colors.blue,
      //   onPressed: () async {
      //     await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      //   },
      //   child: const Text("Please Verified Email", style: TextStyle(color: Colors.white)),
      // ),
  ],
)

      ),
      );
  }
}