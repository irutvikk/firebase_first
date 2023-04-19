import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/Signup.dart';
import 'package:firebase_first/viewdata.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Googlesigninpage extends StatefulWidget {
  const Googlesigninpage({Key? key}) : super(key: key);

  @override
  State<Googlesigninpage> createState() => _GooglesigninpageState();
}

class _GooglesigninpageState extends State<Googlesigninpage> {

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () =>signInWithGoogle().then((value) {
         print("===$value");
      }),
                child: Image.network(
              "https://img.icons8.com/color/512/google-logo.png",
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            )),
            Text("click here to signup"),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Signuppage();
                    },
                  ));
                },
                child: Text("Sign up using email")),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Viewdatapage();
              },));
            }, child: Text("View data"))
          ],
        ),
      ),
    );
  }
}
