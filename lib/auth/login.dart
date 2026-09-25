import 'package:course_firebase1/auth/sinup.dart';
import 'package:course_firebase1/components/button.dart';
import 'package:course_firebase1/components/logo.dart';
import 'package:course_firebase1/components/textformfield.dart';
import 'package:course_firebase1/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    await GoogleSignIn.instance.initialize(
      serverClientId:
          "573818747152-gdu6fku19i7uku05b1vv6idsmgajlcu6.apps.googleusercontent.com",
    );
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
          .authenticate();

      if (googleUser == null) {
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: ((context) => Homepage())),
      );
    } catch (error) {
      print('Done sign out');
    }
  }

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
                      "Login",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Login to continue using the app",
                      style: TextStyle(color: Colors.grey[500], fontSize: 17),
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
                          return "Can't to be empty";
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

                    InkWell(
                      onTap: () async {

                        if(email.text=='')
                        {
                           AwesomeDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Please Enter your email',
  
                        ).show();
                          return ;
                        }

                        try {
                           await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: email.text);

                        AwesomeDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Please check your email and click the link for reset your password',                   
                        ).show();

                        }
                        catch(e){
                          AwesomeDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Please sure that email you enter her is correct then try again',                     
                        ).show();
                        }
                       
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Forgot password",
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),

              CostumButton(
                title: "Login",
                onPressed: () async {
                  if (formState.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                      if (credential.user!.emailVerified) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: ((context) => Homepage())),
                        );
                      } else {
                        await FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                        AwesomeDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Please check your email',
                        ).show();
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found' ||
                          e.code == 'invalid-credential') {
                        AwesomeDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'No user found for that email.',
                        ).show();
                        print(
                          '==========No user found for that email.===========',
                        );
                      } else if (e.code == 'wrong-password') {
                        AwesomeDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Wrong password provided for that user.',
                        ).show();
                        print('Wrong password provided for that user.');
                      }
                    }
                  }
                },
              ),

              SizedBox(height: 10),

              Text(
                "-------------------- Or Login With --------------------",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[500], fontSize: 17),
              ),

              SizedBox(height: 10),

              MaterialButton(
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: Colors.pink[300],
                onPressed: () {
                  signInWithGoogle();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Google",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 15),
                    Image.asset("images/googlelogo.png", width: 30, height: 30),
                  ],
                ),
              ),

              SizedBox(height: 20),

              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: ((context) => SignUp())),
                  );
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: ("Don't have an account? ")),
                        TextSpan(
                          text: ("Sign up"),
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
  }
}
