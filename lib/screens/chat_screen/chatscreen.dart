import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:zchatapp/controllers/chat_controller.dart';
import 'package:zchatapp/screens/chat_screen/components/chat_bubble.dart';
import 'package:zchatapp/services/store_services.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 18, 140, 126),
        actions: const [
          // Icon(Icons.arrow_back_ios),
          Icon(
            Icons.more_vert_rounded,
            color: Colors.white,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${controller.friendname}\n',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: 'Lastseen',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.call),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => Expanded(
                child: controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ),
                      )
                    : StreamBuilder(
                        stream: StoreServices.getChats(controller.chatId),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          } else {
                            return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var doc = snapshot.data!.docs[index];
                                return chatBubble(index, doc);
                              }).toList(),
                            );
                          }
                        },
                      ),
              ),
            ),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controller.messageController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.emoji_emotions),
                            hintText: 'Type Message here...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 18, 140, 126),
                    child: IconButton(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      onPressed: () {
                        print(controller.chatId);
                        controller
                            .sendMessage(controller.messageController.text);
                      },
                      icon: const Icon(Icons.send),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
