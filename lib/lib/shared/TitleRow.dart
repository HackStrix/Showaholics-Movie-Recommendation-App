import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  final title;
  final goto;
  TitleRow({this.title,this.goto});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),
          goto!=null?FlatButton(
//            icon: Icon(Icons.navigate_next),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => goto));
            }, child: Row(
            children: <Widget>[
              Text("View More"),
              Icon(Icons.navigate_next)
            ],
          ),
          ):SizedBox()
        ],
      ),
    );
  }
}
