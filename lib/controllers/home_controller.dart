import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zchatapp/const/firebase.dart';

class HomeController extends GetxController {
 SharedPreferences? prefs;

 static HomeController instance = Get.find();
 var usermage = ''.obs;

 String username = '';
 String userImage = '';

  getUsersDetails()async  {
   await  firebaseFirestore
        .collection(collectionUser)
        .where('Id', isEqualTo: auth.currentUser!.uid)
        .get()
        .then((value) async{
          username =await value.docs[0]['Name'];
          userImage =await value.docs[0]['image_url'];


          prefs =await SharedPreferences.getInstance();         
          prefs!.setStringList('user_details', [
            value.docs[0]['Name'],
            value.docs[0]['image_url']
          ]);
           
        });
  }

  @override
  void onInit() {
  getUsersDetails();
    super.onInit();
  }
}
