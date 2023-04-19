import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Hivepage extends StatefulWidget {
  const Hivepage({Key? key}) : super(key: key);

  @override
  State<Hivepage> createState() => _HivepageState();
}

class _HivepageState extends State<Hivepage> {

  hivefun() async {
    Box box = await Hive.openBox('mainbox');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hivefun();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
