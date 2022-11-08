
import 'package:zchatapp/const/firebase.dart';





class StoreServices{

  //get userdata

 static getUser(String id){
    return firebaseFirestore.collection(collectionUser).where('Id',isEqualTo: id).get();
  }
}