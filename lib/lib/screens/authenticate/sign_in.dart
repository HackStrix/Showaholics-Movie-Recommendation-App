import 'package:flutter/material.dart';
import 'package:project_flix/service/auth.dart';
import 'package:project_flix/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn({this.toggle});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email;
  String password;
  String error ='';

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
//      backgroundColor: Colors.grey[300],
      appBar: AppBar(
//        backgroundColor: Colors.grey[600],
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggle();
          },
              icon: Icon(Icons.person_add),
              label: Text("Register")),
        ],
        title: Text("Sign in",
        style: TextStyle(
//          color: Colors.grey[900]
        ),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child:Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email",
//                    fillColor: Colors.grey[350],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue[600], width: 2.0)
                      ),
                    ),
                    validator: (val) => val.isEmpty? "Enter an Email": null,
                    onChanged: (val) {
                    setState(() {
                      email=val;
                    });
                }
                ),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: "Password",
//                    fillColor: Colors.grey[350],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue[600], width: 2.0)
                      ),
                    ),
                    validator: (val) => val.length < 6? "Enter a password longer than 6+ char": null,
                    obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password=val;
                    });
                  }),
                SizedBox(height: 20,),
                // Sign In button
                RaisedButton(
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 40),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()){
                      setState(() => loading=true);
                      print("Valid");
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result==null){
                        setState(() {
                          error = "Invalid Credentials";
                              loading=false;
                      });
                      }
                    }

                  },
                ),
                SizedBox(height: 14,),
                // Error Text
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
