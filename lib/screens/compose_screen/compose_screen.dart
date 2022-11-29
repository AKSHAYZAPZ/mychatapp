import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:zchatapp/screens/chat_screen/chatscreen.dart';
import 'package:zchatapp/services/store_services.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 140, 126),
      appBar: AppBar(
        title: const Text(
          'New Message',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 18, 140, 126),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: StoreServices.getAllUsers(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                  ),
                );
              } else {
                return GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 180),
                  children: snapshot.data!.docs.mapIndexed(
                    (currentValue, index) {
                      var doc = snapshot.data!.docs[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.red.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                        radius: 35,
                                        backgroundImage: doc['image_url'] == ''
                                            ? const AssetImage(
                                                'assets/images/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg')
                                            : NetworkImage(
                                                    "${doc['image_url']}")
                                                as ImageProvider),
                                    Text("${doc['Name']}"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color.fromARGB(
                                            255, 29, 126, 65),
                                        padding: const EdgeInsets.all(12)),
                                    onPressed: () {
                                      Get.to(() => const ChatScreen(),
                                          transition: Transition.downToUp,
                                          arguments: [doc['Name'], doc['Id']]);
                                    },
                                    icon: const Icon(
                                      Icons.message,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'Message',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
