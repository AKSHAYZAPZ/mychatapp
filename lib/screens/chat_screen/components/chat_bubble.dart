import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zchatapp/const/firebase.dart';
import 'package:intl/intl.dart' as intl;

Widget chatBubble(index, DocumentSnapshot doc) {
  var creation =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(creation);
  return Directionality(
    textDirection: doc['uid'] == auth.currentUser!.uid
        ? TextDirection.rtl
        : TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: doc['uid'] == auth.currentUser!.uid
                  ? const Color.fromARGB(255, 184, 236, 123)
                  : const Color.fromARGB(223, 233, 224, 224),
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: const BoxConstraints(maxWidth: 230),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      '${doc['msg']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
