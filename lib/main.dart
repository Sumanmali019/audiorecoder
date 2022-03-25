import 'package:audiorecoed/firebaseAuth/sign_up.dart';
import 'package:audiorecoed/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebaseAuth/login_service.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCQEBhyHvSfdzHHRbPWohnEwuQ_avQb2Gk",
          appId: "1:887586909506:web:6529697937c4c008cbecdb",
          messagingSenderId: "887586909506",
          storageBucket: "audio-project-ac461.appspot.com",
          projectId: "audio-project-ac461"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        "/": (context) => const Singup(),
        "/Homepage": (context) => const Homepage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Audio recoder',
    );
  }
}
