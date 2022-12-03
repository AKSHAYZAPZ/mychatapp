import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zchatapp/const/firebase.dart';
import 'package:zchatapp/services/store_services.dart';

Widget appbar(GlobalKey<ScaffoldState> key) {
  return Container(
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 18, 140, 126),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(35),
        bottomRight: Radius.circular(35),
      ),
    ),
    padding: const EdgeInsets.only(right: 10),
    height: 120,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              key.currentState!.openDrawer();
            },
            child: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Zchatapp\n',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: "                   Let's talk",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: StoreServices.getUser(auth.currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs[0];
                return CircleAvatar(
                  radius: 24,
                  backgroundImage: data['image_url'] == ''
                      ? const AssetImage('assets/images/images.png')
                      : NetworkImage(data['image_url']) as ImageProvider,
                );
              } else {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}
