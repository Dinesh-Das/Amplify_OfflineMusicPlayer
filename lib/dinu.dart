import 'package:flutter/material.dart';

class Dinu extends StatefulWidget {
  const Dinu({Key? key}) : super(key: key);

  @override
  _DinuState createState() => _DinuState();
}

class _DinuState extends State<Dinu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mani-Dinu Appp"),
      ),
      body: Text("I lovee mani"),
    );
  }
}
