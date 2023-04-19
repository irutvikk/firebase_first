import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_first/imageupload.dart';
import 'package:flutter/material.dart';

class Viewdatapage extends StatefulWidget {
  const Viewdatapage({Key? key}) : super(key: key);

  @override
  State<Viewdatapage> createState() => _ViewdatapageState();
}

class _ViewdatapageState extends State<Viewdatapage> {
  final ref = FirebaseDatabase.instance.ref('realtimedatabase');
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: Container(
      //   height: 55,
      //   width: double.infinity,
      //   margin: EdgeInsets.only(left: 20,right: 20),
      //   decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(30)),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       IconButton(onPressed: () {
      //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //           return Signuppage();
      //         },));
      //       }, icon: Icon(Icons.home,size: 32,color: Colors.white,),),
      //       SizedBox(width: 25,),
      //       IconButton(onPressed: () {
      //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //           return Imageuploadpage();
      //         },));
      //       }, icon: Icon(Icons.add_box_outlined,size: 32,color: Colors.white,),),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        title: Text("View Data"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return Imageuploadpage();
                  },
                ));
              },
              child: Text(
                "Back",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
        ],
      ),
      body: FirebaseAnimatedList(
        physics: BouncingScrollPhysics(),
        query: ref,
        itemBuilder: (context, snapshot, animation, index) {
          return ListTile(
            onTap: () {
              String? idd = snapshot.child('id').value as String?;
              FirebaseDatabase.instance
                  .ref('realtimedatabase')
                  .child(idd!)
                  .remove();
            },
            onLongPress: () async {
              String? idfordelete = snapshot.child('id').value as String?;
              DatabaseReference ref =
                  FirebaseDatabase.instance.ref("realtimedatabase").child(idfordelete!);

              await ref.set({
                "id": idfordelete,
                "Name": "updated ${DateTime.now().second}",
                "age": 25,
                "imageurl": "https://marketplace.canva.com/EAE-xnqWvJk/1/0/1600w/canva-retro-smoke-and-round-light-desktop-wallpapers-JLofAI27pCg.jpg",
                "city": "Ahmedabad"
              });
            },
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage("${snapshot.child('imageurl').value}"),
            ),
            title: Text("${snapshot.child('Name').value}"),
            subtitle: Text("${snapshot.child('age').value}"),
            trailing: Text(
              "${snapshot.child('city').value}",
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
