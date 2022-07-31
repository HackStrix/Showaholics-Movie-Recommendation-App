import 'package:flutter/material.dart';
import 'package:project_flix/service/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class setting extends StatefulWidget {
  @override
  _settingState createState() => _settingState();
}

class _settingState extends State<setting> {
  final AuthService _auth = AuthService();
  String Quality_subtitle = "Medium";
  @override
  void initState() {
    // TODO: implement initState
    _getname().then((value) {
      if (value!=null){
      setState(() {
        Quality_subtitle = value;
      });}
    });
    super.initState();
  }
  void qual_changer() async{
    setState(() async {
      Quality_subtitle = await getUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    qual_changer();
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
            actions: <Widget>[
              FlatButton.icon(onPressed: () async {
                await _auth.SignOut();
              }, icon: Icon(Icons.person,), label: Text("Log Out",))
            ],
          ),
          body: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.high_quality,size: 40,),
                title: Text("Poster Quality"),
                trailing: Quality_subtitle!=null?Text(Quality_subtitle):Text(""),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => Quality()),);
                },
              )
            ],
          )
      ),
    );
  }
}


class Quality extends StatefulWidget {

  @override
  _QualityState createState() => _QualityState();
}

class _QualityState extends State<Quality> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quality"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
          title: Text("High Quality"),
            subtitle: Text("High data usage"),
            onTap: (){
                _qualitychanger('https://image.tmdb.org/t/p/w300',"High");
                Navigator.pop(context);
            },
        ),
          ListTile(
            title: Text("Medium Quality"),
            subtitle: Text("Moderate data usage"),
            onTap: (){
              _qualitychanger('https://image.tmdb.org/t/p/w185',"Medium");
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Low Quality"),
            subtitle: Text("Low data usage"),
            onTap: (){
              _qualitychanger('https://image.tmdb.org/t/p/w92',"Low");
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

_qualitychanger(String url,String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('url', url);
  await prefs.setString("quality_name", name);
}
Future<String> getUrl() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String abc = prefs.getString("quality_name");
//  print(abc);
  return abc;
}
Future<String> _getname()async{
  final prefs = await StreamingSharedPreferences.instance;
  Preference<String> listen =  prefs.getString("quality_name");
  listen.listen((value) {
    return value;
  });
}
