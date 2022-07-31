import 'package:flutter/material.dart';
import 'package:project_flix/screens/authenticate/register.dart';
import 'package:project_flix/screens/authenticate/sign_in.dart';

class Autheticate extends StatefulWidget {
  @override
  _AutheticateState createState() => _AutheticateState();
}

class _AutheticateState extends State<Autheticate> {

  bool showSignIn = false;
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SafeArea(child: SignIn(toggle: toggleView));
    }
    else{
      return SafeArea(child:Register(toggle: toggleView));
    }
  }
}
