// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media/features/auth/login_screen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: FirebaseOptions(
    apiKey: 'Api_Key',
    appId: "1:927665244674:android:1bbf42b6ad0194a7e2751b",
    messagingSenderId: "927665244674",
    projectId: "social-343b9",
    storageBucket: "social-343b9.appspot.com",
  )
);
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.grey.shade900, elevation: 0),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey.shade900),
      debugShowCheckedModeBanner: false,
      home: LogInPage(),
    );
  }
}
