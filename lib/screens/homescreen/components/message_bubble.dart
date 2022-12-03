import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zchatapp/const/firebase.dart';
import '../../chat_screen/chatscreen.dart';
import 'package:intl/intl.dart' as intl;

Widget messageBubble(DocumentSnapshot doc) {
  var t =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return Card(
    child: ListTile(
      onTap: () {
        Get.to(() => const ChatScreen(),
            transition: Transition.downToUp,
            arguments: [
              auth.currentUser!.uid == doc['toId']
                  ? doc['user_name']
                  : doc['friend_name'],
              auth.currentUser!.uid == doc['toId']
                  ? doc['fromId']
                  : doc['toId'],
            ]);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 25,
        child: Image.asset(
          "assets/images/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
        ),
      ),
      title: auth.currentUser!.uid == doc['toId']
          ? Text("${doc['user_name']}")
          : Text(
              "${doc['friend_name']}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
      subtitle: Text("${doc['last_msg']}"),
      trailing: Text(
        time,
        style: TextStyle(color: Colors.grey[400]),
      ),
    ),
  );
}
