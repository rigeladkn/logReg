import 'package:flutter/material.dart';
import 'package:loginregister/pages/loginRegister.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginRegister(), //interface du formulaire
    );
  }
}