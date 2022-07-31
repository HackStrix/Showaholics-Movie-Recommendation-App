import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.grey[400],
//      color: Colors.grey[400],
//    color: Colors.white,
      child: SpinKitFadingCircle(
        color: Colors.blue,
        size: 55.0,
      ),
    );
  }
}
