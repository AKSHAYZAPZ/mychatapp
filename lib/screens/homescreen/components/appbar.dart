import 'package:flutter/material.dart';

Widget appbar(GlobalKey <ScaffoldState> key) {
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
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(
              "assets/images/images.png",
            ),
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    ),
  );
}
