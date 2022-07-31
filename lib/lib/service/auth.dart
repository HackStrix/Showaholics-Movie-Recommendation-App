import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_flix/model/user.dart';
import 'package:project_flix/service/Database/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null? User(uid: user.uid) : null;
  }
  // Auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
//      .map((FirebaseUser user) => _userfromfirebasefunction(user));
      .map(_userFromFirebaseUser);
  }
  // sign in anon
  Future SignInasAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;

      return user;
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  // sing in with email & pass
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  // register with email & pass

  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      DatabaseService(uid: user.uid).addUserData(id:[-1],movieOrTv: "tv");
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out

  Future SignOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}
