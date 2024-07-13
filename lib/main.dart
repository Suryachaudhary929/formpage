import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:formpage/login_page.dart';




void main()async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
  final Future <FirebaseApp> initialization = Firebase.initializeApp();
   

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
title: "website",
home:Formpage() ,
    );
  }
}
class AppSettings {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}