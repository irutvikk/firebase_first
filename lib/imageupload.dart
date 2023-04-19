import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_first/Signup.dart';
import 'package:firebase_first/viewdata.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imageuploadpage extends StatefulWidget {
  const Imageuploadpage({Key? key}) : super(key: key);

  @override
  State<Imageuploadpage> createState() => _ImageuploadpageState();
}

class _ImageuploadpageState extends State<Imageuploadpage> {
  String imagepath = "";
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 20);
                  setState(() {
                    imagepath = image!.path;
                  });
                },
                child: imagepath != ""
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(File(imagepath)),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 80,
                      )),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "name"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: age,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "age",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 6,
                    child: TextField(
                      controller: city,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "city"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  final storageref = FirebaseStorage.instance.ref();
                  final spaceref = storageref
                      .child("Myimages/Image${Random().nextInt(999)}.jpg");
                  await spaceref.putFile(File(imagepath));

                  spaceref.getDownloadURL().then((value) async {
                    print("=======$value");

                    DatabaseReference ref = FirebaseDatabase.instance
                        .ref("realtimedatabase")
                        .push();
                    // String? id = ref.key;
                    await ref.set({
                      "id": ref.key,
                      "Name": "${name.text}",
                      "age": age.text,
                      "imageurl": "$value",
                      "city": "${city.text}"
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                              "Data Submitted",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.blue,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return Viewdatapage();
                        },
                      ));
                    });
                  });
                },
                child: Text("Upload")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Signuppage();
                    },
                  ));
                },
                child: Text("Back to Signup using Email")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Viewdatapage();
                    },
                  ));
                },
                child: Text("View data"))
          ],
        ),
      ),
    );
  }
}
