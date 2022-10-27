import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zchatapp/screens/home_screen.dart';

import '../auth/firebase_auth.dart';

class AuthController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final otpController = List.generate(6, (index) => TextEditingController());
  var collectionUser = 'users';

  var isOtpSent = false.obs;

  late final PhoneVerificationCompleted phoneVerificationCompleted;
  late final PhoneVerificationFailed phoneVerificationFailed;
  late PhoneCodeSent phoneCodeSent;
  String verificationID = '';

  sendOtp() async {
    phoneVerificationCompleted = (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    };

    phoneVerificationFailed = (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
    };

    phoneCodeSent = (String verificationId, int? resendToken) {
      verificationID = verificationId;
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text}",
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e.toString());
    }
  }

//verify otp
  verfyOtp() async {
    String otp = '';

    //getting all textfields data
    for (var i = 0; i < otpController.length; i++) {
      otp += otpController[i].text;
    }
    try {
      print('otp $otp');
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: otp,
      );
      //getting user
      final User? userval =
          (await auth.signInWithCredential(phoneAuthCredential)).user;

      if (userval != null) {
        print('user not null');
        //store user into database
        DocumentReference store =
            FirebaseFirestore.instance.collection(collectionUser).doc(userval.uid);
        await store.set(
          {
            'Id': userval.uid,
            'Name': usernameController.text.toString(),
            'Phone': phoneController.text.toString(),
          },
        );

        //showingtoast to login
         Get.snackbar('Logged in', 'Login Successful');
        Get.offAll(() => const HomeScreen());
      }
    } catch (e) {
      // print(e.toString());
    }
  }
}
