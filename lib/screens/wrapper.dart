import 'package:flutter/material.dart';
import 'package:project_flix/model/user.dart';
import 'package:project_flix/screens/authenticate/autheticate.dart';
import 'package:project_flix/screens/authenticate/register.dart';
import 'package:project_flix/screens/authenticate/sign_in.dart';
import 'package:project_flix/screens/home/search&add.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user==null){
      return Autheticate();
    } else {
      return user==null?Loading():home();
    }
  }
}

