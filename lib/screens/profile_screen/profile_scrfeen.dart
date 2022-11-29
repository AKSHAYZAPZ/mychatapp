import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zchatapp/const/firebase.dart';
import 'package:zchatapp/controllers/profile_controller.dart';
import 'package:zchatapp/screens/homescreen/home_screen.dart';
import 'package:zchatapp/screens/profile_screen/components/picker_dailog.dart';
import 'package:zchatapp/services/store_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.offAll(()=> HomeScreen());
          
        }, icon: const Icon(Icons.arrow_back_ios)),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          
          TextButton(
            onPressed: () async {
              
              if (controller.imgpath.isEmpty) {
                controller.updateProfile();
              } else {
                await controller.uploadImage();
                controller.updateProfile();
              }
            },
            
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 47, 79, 79),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder<QuerySnapshot>(
          future: StoreServices.getUser(auth.currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!.docs[0];
              controller.nameController.text = data['Name'];
              controller.phoneController.text = data['Phone'];
              controller.aboutController.text = data['about'];
              return Stack(
                // alignment: Alignment.topLeft,
                children: [
                  Positioned(
                    child: Container(
                      height: 130,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 47, 79, 79),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(200)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 130,
                    top: 50,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(300),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Obx(
                          () => CircleAvatar(
                            radius: 63,
                            backgroundImage: controller.imgpath.isEmpty &&
                                    data['image_url'] == ''
                                ? const AssetImage(
                                    'assets/images/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg')
                                : controller.imgpath.isNotEmpty
                                    ? Image.file(File(controller.imgpath.value))
                                        .image
                                    : NetworkImage(data['image_url']),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  bottom: 10,
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () {
                                        Get.dialog(
                                            pickerDialog(context, controller));
                                        // print('cam clicked');
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_rounded,
                                        color: Colors.black,
                                        size: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 400,
                        color: Colors.white,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            ListTile(
                              style: ListTileStyle.drawer,
                              leading: const Icon(
                                Icons.person,
                              ),
                              title: TextFormField(
                                // onFieldSubmitted: (value) {
                                //   controller.updateProfile();
                                // },
                                controller: controller.nameController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Name',
                                    suffixIcon: Icon(Icons.edit)),
                              ),
                              subtitle: const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  'This is your username or pin.This name will be visible to your quick chat friends.',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.info,
                              ),
                              title: TextFormField(
                                // onFieldSubmitted: (value) {
                                //    controller.updateProfile();
                                // },
                                controller: controller.aboutController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'About',
                                  suffixIcon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.call,
                              ),
                              title: TextFormField(
                                controller: controller.phoneController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Phone',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
