import 'package:flutter/material.dart';

Widget tabbar() {
  return Container(
    color: Colors.white,
   
      child: TabBar(
        labelColor: Colors.black,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelColor: Colors.grey[500],
      
        tabs: const [
          Tab(
            text: 'Chats',
            
          ),
          Tab(
           
            child: Icon(Icons.call),
          ),
        ],
      ),
    
  );
}
