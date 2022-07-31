import 'package:flutter/material.dart';
import 'package:project_flix/screens/home/myflix.dart';
import 'package:project_flix/screens/home/Home.dart';
import 'package:project_flix/screens/home/whatisnew.dart';
import 'package:project_flix/service/auth.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:project_flix/screens/home/setting.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:project_flix/shared/loading.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final AuthService _auth = AuthService();
  List viewList = [Home(),whatisnew(),myflix(),setting()];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.grey[300],
          selectedItemBorderColor: Colors.blue[600],
          selectedItemBackgroundColor: Colors.blueAccent,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'Home',
          ),
          FFNavigationBarItem(
            iconData: Icons.movie_creation,
            label: 'MyFlix',
          ),
          FFNavigationBarItem(
            iconData: Icons.local_movies,
            label: 'Movies',
          ),

          FFNavigationBarItem(
            iconData: Icons.settings,
            label: 'Settings',
          ),
        ],
      ),

      body: viewList[selectedIndex],
    );
  }
}
