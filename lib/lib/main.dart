import 'package:flutter/material.dart';
import 'package:project_flix/model/user.dart';
import 'package:project_flix/screens/wrapper.dart';
import 'package:project_flix/service/auth.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,//this checks the value of user current status
      child: MaterialApp(
        // light mode theme data
        theme: ThemeData(
          // used to change the sub tabs of appbar in FavouriteTabbed file
          tabBarTheme: TabBarTheme(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.orange,
          ),
          brightness: Brightness.light,
          // used to change the app bar colors and shades
          appBarTheme: AppBarTheme(
            color: Colors.grey,
            actionsIconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),

            // used to change the heading colors
            primaryTextTheme: TextTheme(
              headline6: TextStyle(
                  color: Colors.black
              ),
            )
        ),

        //Dark mode theme data
        // check the options of this through above light mode
        darkTheme: ThemeData(
          bottomAppBarColor: Colors.black54,
          appBarTheme: AppBarTheme(
            color: Colors.grey[900],
            actionsIconTheme: IconThemeData(
              color: Colors.orange,
            ),
          ),
          canvasColor: Colors.black38,
          brightness: Brightness.dark,
          backgroundColor: Colors.black38,
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.orange
            ),
            )
        ),
        // this changes the current mode ie light, dark, or system()
        themeMode: ThemeMode.dark,
        home: Wrapper(),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
