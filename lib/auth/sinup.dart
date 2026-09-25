import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:course_firebase1/auth/login.dart';
import 'package:course_firebase1/components/button.dart';
import 'package:course_firebase1/components/logo.dart';
import 'package:course_firebase1/components/textformfield.dart';
import 'package:course_firebase1/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Form(
                key: formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),

                    CostumLogoOuth(),

                    SizedBox(height: 20),

                    Text(
                      "SignUp",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Signup to continue using the app",
                      style: TextStyle(color: Colors.grey[500], fontSize: 17),
                    ),

                    SizedBox(height: 25),

                    Text(
                      "User Name",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    CostumTextForm(
                      hintText: "Enter your User Name",
                      mycontroller: username,
                      validator: (val) {
                        if (val == "") {
                          return "Can't be empty";
                        }
                      },
                    ),

                    SizedBox(height: 25),

                    Text(
                      "Email",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    CostumTextForm(
                      hintText: "Enter your Email",
                      mycontroller: email,
                      validator: (val) {
                        if (val == "") {
                          return "Can't be empty";
                        }
                      },
                    ),

                    SizedBox(height: 25),

                    Text(
                      "Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    CostumTextForm(
                      hintText: "Enter your Password",
                      mycontroller: password,
                      validator: (val) {
                        if (val == "") {
                          return "Can't to be empty";
                        }
                      },
                    ),

                    SizedBox(height: 10),

                    Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.grey[900], fontSize: 17),
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),

              CostumButton(
                title: "SignUp",
                onPressed: () async {
                  if (formState.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                         await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: ((context) => Login())),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                        AwesomeDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'The password provided is too weak.',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                        AwesomeDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'The account already exists for that email.',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),

              SizedBox(height: 20),

              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: ("Have an account? ")),
                        TextSpan(
                          text: ("Login"),
                          style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
