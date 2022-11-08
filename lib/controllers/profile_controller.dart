import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zchatapp/const/firebase.dart';

class ProfileController extends GetxController{


  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  var phoneController = TextEditingController();

  Future<void>updateProfile()async{
   var store =  firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);

   await store.set({
    'Name':nameController.text,
    'about':aboutController.text,
   },SetOptions(merge: true));
   
  }
  
}