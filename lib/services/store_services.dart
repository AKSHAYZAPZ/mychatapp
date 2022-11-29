import 'package:zchatapp/const/firebase.dart';

class StoreServices {
  //get userdata

  static getUser(String id) {
    return firebaseFirestore
        .collection(collectionUser)
        .where('Id', isEqualTo: id)
        .get();
  }

  static getAllUsers() {
    return firebaseFirestore.collection(collectionUser).snapshots();
  }

  static getChats(String chatId) {
    return firebaseFirestore
        .collection(collectionChats)
        .doc(chatId)
        .collection(collectionMessages)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getMessages() {
    return firebaseFirestore
        .collection(collectionChats)
        // .where("users.${auth.currentUser!.uid}", isEqualTo: null)
        // .where('fromId',isEqualTo: auth.currentUser!.uid)
        // .where('last_msg', isNotEqualTo: '')
        .where('chatRoom.${auth.currentUser!.uid}',isNull: true)
        .snapshots();
  }
}
