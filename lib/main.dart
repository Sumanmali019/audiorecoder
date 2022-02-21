// import 'package:audiorecoed/screens/home_page.dart';
import 'package:audiorecoed/screens/home_page.dart';
import 'package:audiorecoed/widgets/isrecodring.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Audio recoder',
      // home: Homepage(title: 'Audio recoder'),
      home: Buildstate(),
    );
  }
}
