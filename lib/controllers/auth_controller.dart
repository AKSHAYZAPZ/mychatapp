import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zchatapp/const/firebase.dart';
import 'package:zchatapp/screens/homescreen/home_screen.dart';
import 'package:zchatapp/screens/start_screen.dart';
import 'package:zchatapp/screens/verfication_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
 
  late Rx<User?> _currentUser;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final otpController = List.generate(6, (index) => TextEditingController());
 

  var isOtpSent = false.obs;
  var formKey = GlobalKey<FormState>();

   PhoneVerificationCompleted? phoneVerificationCompleted;
  PhoneVerificationFailed? phoneVerificationFailed;
   PhoneCodeSent? phoneCodeSent;
  String verificationID = '';

  @override
  void onReady() {
    super.onReady();
    _currentUser = Rx<User?>(auth.currentUser);
   _currentUser.bindStream(auth.userChanges());
    ever(_currentUser, initialScreen);
  }

  initialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const StartScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  sendOtp(phone) async {
    phoneVerificationCompleted = (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    };

    phoneVerificationFailed = (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        // print('The provided phone number is not valid.');
      }
    };

    phoneCodeSent = (String verificationId, int? resendToken) {
      verificationID = verificationId;
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        verificationCompleted: phoneVerificationCompleted!,
        verificationFailed: phoneVerificationFailed!,
        codeSent: phoneCodeSent!,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      // print(e.toString());
    }
  }

//verify otp
  verfyOtp(String user, phone) async {
    String otp = '';

    //getting all textfields data
    for (var i = 0; i < otpController.length; i++) {
      otp += otpController[i].text;
    }
    try {
      // print('otp $otp');
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: otp,
      );
      //getting user
      final User? userval =
          (await auth.signInWithCredential(phoneAuthCredential)).user;

      if (userval != null) {
        // print('user not null');
        //store user into database
        DocumentReference store = FirebaseFirestore.instance
            .collection(collectionUser)
            .doc(userval.uid);
        await store.set(
          {
            'Id': userval.uid,
            'Name': user,
            'Phone': phone,
            'about':'',
            'image_url':'',

          },SetOptions(merge: true),
        );

        //showingtoast to login
        Get.snackbar('Logged in', 'Login Successful');
        Get.offAll(() => HomeScreen());
      }
    } catch (e) {
      // print(e.toString());
    }
  }

  void logout() async {
    await auth.signOut();
    usernameController.text ='';
    phoneController.text ='';
    isOtpSent.value =false;
   for (var i = 0; i < otpController.length; i++) {
       otpController[i].text ='';
    }
  }
}
