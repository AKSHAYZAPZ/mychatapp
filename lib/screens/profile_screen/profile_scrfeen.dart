import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zchatapp/const/firebase.dart';
import 'package:zchatapp/controllers/profile_controller.dart';
import 'package:zchatapp/services/store_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              controller.updateProfile();
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 18, 140, 126),
        title: const Text('Profile',  style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<QuerySnapshot>(
          future: StoreServices.getUser(currentUser!.uid),
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
                        color: Color.fromARGB(255, 18, 140, 126),
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
                        child: CircleAvatar(
                          radius: 63,
                          backgroundImage: const AssetImage(
                              'assets/images/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                          child: Stack(
                            children: [
                              Positioned(
                                right: 0,
                                bottom: 10,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey,
                                  child: IconButton(
                                    onPressed: () {
                                      // print('cam clicked');
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.white,
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 400,
                      color: Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            style: ListTileStyle.drawer,
                            leading: const Icon(
                              Icons.person,
                              size: 32,
                            ),
                            title: TextFormField(
                              onFieldSubmitted: (value) {
                                controller.updateProfile();
                              },
                              controller: controller.nameController,
                              decoration: const InputDecoration(
                                  labelText: 'Name',
                                  suffixIcon: Icon(Icons.edit)),
                            ),
                            subtitle: const Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                'This is your username or pin.this name will be visible to your quick chat friens.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.info,
                              size: 32,
                            ),
                            title: TextFormField(
                              onFieldSubmitted: (value) {
                                 controller.updateProfile();
                              },
                              controller: controller.aboutController,
                              decoration: const InputDecoration(
                                labelText: 'About',
                                suffixIcon: Icon(Icons.edit),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.info,
                              size: 32,
                            ),
                            title: TextFormField(
                              controller: controller.phoneController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: 'Phone',
                              ),
                            ),
                          ),
                        ],
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
