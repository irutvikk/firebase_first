import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/Signup.dart';
import 'package:firebase_first/viewdata.dart';
import 'package:flutter/material.dart';

import 'googlesignin.dart';

class Signupusingphone extends StatefulWidget {
  const Signupusingphone({Key? key}) : super(key: key);

  @override
  State<Signupusingphone> createState() => _SignupusingphoneState();
}

class _SignupusingphoneState extends State<Signupusingphone> {
  TextEditingController phone = TextEditingController();
  TextEditingController otp = TextEditingController();
  int val=0;
  String varificationid="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone otp")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
            ),
            TextField(
              controller: phone,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "phone number"),
            ),
            SizedBox(
              height: 20,
            ),
            val==0?SizedBox(height: 10,):TextField(
              controller: otp,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "otp"),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                onPressed: ()  async {
                  setState(() async {
                    if(val==0) {
                      val = 1;
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '+91${phone.text}',
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          setState(() {
                            varificationid = verificationId;
                          });
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    }
                    if(val==1){
                      FirebaseAuth auth = FirebaseAuth.instance;
                      String smsCode = '${otp.text}';
                      // Create a PhoneAuthCredential with the code
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: varificationid, smsCode: smsCode);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Successfully submit")));
                      });
                    }
                  });
                },
                child:val==0?Text(
                  "Send otp",
                  style: TextStyle(color: Colors.white),):Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),)
              ,),
            SizedBox(
              height: 20,
            ),
            // ElevatedButton(onPressed: () {
            //
            // }, child: Text("Sign up using phone number")),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Signuppage();
              },));
            }, child: Text("Sign Up using email")),ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Googlesigninpage();
              },));
            }, child: Text("Sign Up using Google")),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Viewdatapage();
              },));
            }, child: Text("View Data")),
          ],
        ),
      ),
    );
  }
}
