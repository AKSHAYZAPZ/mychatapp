import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                          const TextSpan(
                            text: 'Username\n',
                            style: TextStyle(
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
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return Directionality(
                    textDirection:
                        index.isEven ? TextDirection.rtl : TextDirection.ltr,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Image.asset(
                                'assets/images/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                             
                            decoration: BoxDecoration(
                              
                              color: index.isEven
                                  ? const Color.fromARGB(255, 184, 236, 123)
                                  : const Color.fromARGB(223, 233, 224, 224),
                              borderRadius: BorderRadius.circular(12),
                              
                            ),
                            constraints: const BoxConstraints(maxWidth: 230),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      'hello hai ...how are you....habeebi come to dubai???',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      '12:00 AM',
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
                },
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
                      color:const Color.fromARGB(255, 255, 255, 255),
                      onPressed: () {},
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
