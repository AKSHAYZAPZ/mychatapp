import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zchatapp/screens/chat_screen/chatscreen.dart';

Widget chatComponent() {
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Get.to(()=>ChatScreen(),transition: Transition.downToUp);
            },
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: Image.asset(
                "assets/images/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                
              ),
            ),
            title: const Text(
              'Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text('Message here'),
            trailing: Text(
              'Lastseen',
              style: TextStyle(color: Colors.grey[400]),
            ),
          );
        },
      ),
    ),
  );
}
