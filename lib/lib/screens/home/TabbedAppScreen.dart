import 'package:flutter/material.dart';
import 'package:project_flix/screens/Search/search.dart';
import 'file:///D:/Users/Narula/AndroidStudioProjects/project_flix/lib/screens/home/Home.dart';
import 'package:project_flix/service/auth.dart';
import 'package:project_flix/screens/home/setting.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:project_flix/screens/home/FavouriteTabbedScreen.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final AuthService _auth = AuthService();
  // tab navigation list
  List viewList = [Home(),Search(),FavouriteTabbedScreen(),setting()];
  //this index changes the view
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.black54,
          selectedItemBorderColor: Colors.orange[600],
          selectedItemBackgroundColor: Colors.orange,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.white,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            // value index is changed from here
            selectedIndex = index;
          });
        },
        // this is the appearance of tabs
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'Home',
          ),
          FFNavigationBarItem(
            iconData: Icons.search,
            label: 'Search',
          ),
          FFNavigationBarItem(
            iconData: Icons.favorite,
            label: 'Favourites',
          ),

          FFNavigationBarItem(
            iconData: Icons.settings,
            label: 'Settings',
          ),
        ],
      ),

      body: viewList[selectedIndex],//view is changed from here
    );
  }
}
