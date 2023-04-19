import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/Signin.dart';
import 'package:firebase_first/googlesignin.dart';
import 'package:firebase_first/viewdata.dart';
import 'package:flutter/material.dart';

import 'Signupphone.dart';
import 'imageupload.dart';

class Signuppage extends StatefulWidget {

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Sign up page")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Email"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Password"),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration using email Successfull")));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Week Password")));
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email Already Exist")));
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                )),

            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.orange)),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Signinpage();
                    },
                  ));
                },
                child: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white),
                )),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Signupusingphone();
              },));
            }, child: Text("Sign up using phone number")),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Googlesigninpage();
              },));
            }, child: Text("Sign up using Google")),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Imageuploadpage();
              },));
            }, child: Text("image upload")),
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
