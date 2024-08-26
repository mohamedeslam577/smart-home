import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test2/homepage.dart';
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
      apiKey: "AIzaSyAYVussAOE2-0cbToZy5xuqg0cnzAnGsiE",
      appId: "1:1031709974591:android:96fa869e3016df6524188a",
      messagingSenderId: "1031709974591",
      projectId: "test2-8b9ce",
    ),
        );
    print("Firebase Initialized");
  } catch (e) {
    print("Firebase initialization error: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

String? text;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(

      )
    );
  }
}
