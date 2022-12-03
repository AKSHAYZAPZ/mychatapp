import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:zchatapp/screens/homescreen/components/message_bubble.dart';
import 'package:zchatapp/services/store_services.dart';

Widget chatComponent() {
  return Container(
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: StreamBuilder(
          stream: StoreServices.getMessages(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('Start a Conversation'),
              );
            } else {
              return ListView(
                children: snapshot.data!.docs.mapIndexed(
                  (currentValue, index) {
                    var doc = snapshot.data!.docs[index];
                    return messageBubble(doc);
                  },
                ).toList(),
              );
            }
          },
        )),
  );
}
