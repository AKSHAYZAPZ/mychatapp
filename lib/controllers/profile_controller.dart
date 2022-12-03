

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:zchatapp/const/firebase.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {


  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  var phoneController = TextEditingController();

  var imgpath = ''.obs;
  var imglink = '';

  Future<void> updateProfile() async {
    var store =
        firebaseFirestore.collection(collectionUser).doc(auth.currentUser!.uid);

    await store.set({
      'Name': nameController.text,
      'about': aboutController.text,
        
    }, SetOptions(merge: true));
  }

  selectImage(context, source) async {
    final image = await ImagePicker().pickImage(source: source);
    try {
      if(image !=null){
          imgpath.value = image.path;
      VxToast.show(
        context,
        msg: 'Profile Uploded',
        bgColor: Colors.black,
        textColor: Colors.white,
      );
      }
    
    } on PlatformException catch (e) {
      VxToast.show(
        context,
        msg: e.toString(),
        bgColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  uploadImage()async{
   var name = basename( imgpath.value);
   var destination = 'images/${auth.currentUser!.uid}/$name';
  Reference ref = FirebaseStorage.instance.ref().child(destination);
  await ref.putFile(File(imgpath.value));
  var d=await ref.getDownloadURL();
  // print(d);
  imglink = d;
  firebaseFirestore .collection(collectionUser).doc(auth.currentUser!.uid).update({'image_url':imglink});
  }



}