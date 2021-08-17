import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> isEmailVerified();

  Future<void> signOut();
}

class Auth implements BaseAuth {
  //contient les méthodes pour interagir avec Firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    //print(_firebaseAuth);
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    //print(_firebaseAuth.currentUser);
    var userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password); //type du retour ?
    User user = userCredential.user;
    return user.uid;
  }

  Future<User> getCurrentUser() async {
    User user = firebaseAuth.currentUser;
    return user;
  }

  Future<void> sendEmailVerification() async {
    User user = await getCurrentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User user = await getCurrentUser();
    return user.emailVerified;
  }

  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }
}
