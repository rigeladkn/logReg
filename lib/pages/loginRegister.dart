import 'package:flutter/material.dart';
import 'package:loginregister/widgets/formWidget.dart';

class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Login_Register"),
        centerTitle: true,
      ),
      body: new Stack(children: [
        new FormWidget(),
        _isLoading
            ? new CircularProgressIndicator()
            : new Container(height: 0.0, width: 0.0)
      ]),
    );
  }
}
