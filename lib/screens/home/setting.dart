import 'package:flutter/material.dart';
import 'package:project_flix/service/auth.dart';

class setting extends StatefulWidget {
  @override
  _settingState createState() => _settingState();
}

class _settingState extends State<setting> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          actions: <Widget>[
            FlatButton.icon(onPressed: () async {
              await _auth.SignOut();
            }, icon: Icon(Icons.person), label: Text("Log Out"))
          ],
        ),
      )
    );
  }
}
