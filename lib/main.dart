import 'package:flutter/material.dart';
import 'package:spiser_manager/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spiser Manager',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(210, 86, 76, 1)
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}