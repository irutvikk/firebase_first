import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/Signup.dart';
import 'package:firebase_first/Signupphone.dart';
import 'package:firebase_first/viewdata.dart';
import 'package:flutter/material.dart';

import 'googlesignin.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({Key? key}) : super(key: key);

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign in page")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(width: double.infinity,),
            TextField(
              controller: email,
              decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Email"),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: password,
              decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Password"),
            ),
            SizedBox(height: 20,),
            TextButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text
                  );
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully login")));
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("user not found for email")));
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("password is not matching")));
                    print('Wrong password provided for that user.');
                  }
                }
            }, child: Text("Sign in",style: TextStyle(color: Colors.white),)),
            TextButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.amber.shade800)),
              onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Signuppage();
              },));
            }, child: Text("Sign up",style: TextStyle(color: Colors.white),)),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Signupusingphone();
              },));
            }, child: Text("Sign in using phone number")),ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Googlesigninpage();
              },));
            }, child: Text("Sign up using google")),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Viewdatapage();
              },));
            }, child: Text("View Data"))
          ],
        ),
      ),
    );
  }
}
