import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginregister/utils/BaseAuth.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}


class FormWidget extends StatefulWidget {

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  String _email;
  String _password;
  bool _isLoginPage = true;
  bool _isLoading;
  String _userId;
  AuthStatus _authStatus;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Auth auth = new Auth();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
        child: new ListView(
          shrinkWrap: true,
      children: [
        showLogo(),
        showEmailInputField(),
        showPasswordInputField(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new RichText(
            textAlign: TextAlign.center,
            text: new TextSpan(
            text : _isLoginPage ? "Vous n'avez pas encore de compte ? "  : " Vous avez déjà un compte ?",
            style: new TextStyle(color : Colors.grey, fontSize: 13.0),
            
            children: <TextSpan>[
              new TextSpan(
                text : _isLoginPage ? " Créer un compte"  : " Se connecter",
                style: new TextStyle(
                  color : Colors.blue,
                ),
                recognizer: new TapGestureRecognizer()..onTap = (){
                  setState(() {
                    _isLoginPage = !_isLoginPage;
                  });
                },
              ),
            ]
          )),
        ),
        new Padding(padding: EdgeInsets.only(bottom : 40.0)),
        Row(
          children: [
            new Padding(padding: EdgeInsets.only(left : 60.0)),
            new Expanded(
                      child: new MaterialButton(
                        padding: EdgeInsets.all(12.0),
                color: Colors.blue,
                child: new Text(_isLoginPage ? 'Login' : 'Sign up' , style: new TextStyle(color : Colors.white),),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.all(Radius.circular(8.0))),
                onPressed: () => validateAndSubmit(),
              ),
            ),
            new Padding(padding: EdgeInsets.only(left : 60.0)),
          ],
        ),
        // new RichText(text:),
      ],
    ));
  }

  Hero showLogo() {
    return new Hero(
        tag: 'hero',
        child: new Padding(
          padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 48.0,
            child: Image.asset("images/coq.png"),
          ),
        ));
  }

  Padding showEmailInputField() {
    return new Padding(
      padding: EdgeInsets.all(8.0),
      child: new TextFormField(
        keyboardType: TextInputType.emailAddress,
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Email..',
           hintStyle: new TextStyle(color: Colors.grey),
          icon: new Icon(Icons.email, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Email requis !' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Padding showPasswordInputField() {
    return new Padding(
      padding: EdgeInsets.all(8.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,
        obscureText: true,
        decoration: new InputDecoration(
           hintText:'Password..',
           hintStyle: new TextStyle(color: Colors.grey),
          icon: new Icon(Icons.person, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Password requis !' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  void validateAndSubmit() async {
    setState(() {
      _isLoading = true;
    });
    if (_isLoginPage) {
      _userId = await auth.signIn(_email, _password);
    } else {
      _userId = await auth.signUp(_email, _password);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void loginCallback() {
    auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        _authStatus = AuthStatus.LOGGED_IN;
      });
    });
  }

    void logoutCallback() {
    setState(() {
      _authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

}

