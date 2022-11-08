import 'package:flutter/material.dart';
import 'package:zchatapp/screens/homescreen/components/chat_componont.dart';

Widget tabbarView() {
  return Expanded(
    child: Container(
      child: TabBarView(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
           
            ),
            child: chatComponent(),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.yellow,
            
            ),
          ),
        ],
      ),
    ),
  );
}
