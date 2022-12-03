import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zchatapp/const/drawer.dart';
import 'package:zchatapp/const/firebase.dart';
import 'package:zchatapp/controllers/auth_controller.dart';
import 'package:zchatapp/screens/profile_screen/profile_scrfeen.dart';
import 'package:zchatapp/services/store_services.dart';

Widget drawer() {
  return Drawer(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(25),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: FutureBuilder(
        future: StoreServices.getUser(auth.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.docs[0];
            return Column(
              children: [
                ListTile(
                  leading: IconButton(
                    color: Colors.black,
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  title: const Text(
                    'Settings',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                  ),
                ),
                CircleAvatar(
                    radius: 45,
                    backgroundImage: data['image_url'] == ''
                        ? const AssetImage(
                            'assets/images/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg')
                        : NetworkImage(data['image_url']) as ImageProvider),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data['Name'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.black,
                  height: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView(
                  shrinkWrap: true,
                  children: List.generate(
                    draweIconsList.length,
                    (index) => ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.offAll(() => const ProfileScreen(),
                                transition: Transition.downToUp);
                        }
                      },
                      leading: Icon(draweIconsList[index]),
                      title: drawListTitles[index],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const ListTile(
                  leading: Icon(inviteIcon),
                  title: Text('Invite Friend'),
                ),
                const Spacer(),
                ListTile(
                  onTap: () {
                    AuthController.instance.logout();
                  },
                  leading: const Icon(logoutIcon),
                  title: const Text('Logout'),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
            );
          }
        },
      ),
    ),
  );
}
