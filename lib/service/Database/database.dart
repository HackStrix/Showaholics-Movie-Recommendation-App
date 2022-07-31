import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  final CollectionReference idCollection = Firestore.instance.collection("ids");
  Future addUserData({List id,String movieOrTv}) async{
    if (id[0] == -1){
      return await idCollection.document(uid).setData({
        "tv":[],
        "movie":[]
      }).then((_) => print("success"));
    }
    else{
      return await idCollection.document(uid).setData({
        movieOrTv:id
      }).then((_){
        print("success!");
      });
    }
  }

  Future getDataByQuery(String uid)  async{
    return await idCollection.document(uid).get();
  }

}