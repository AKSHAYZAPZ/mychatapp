import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zchatapp/const/drawer.dart';
import 'package:zchatapp/screens/profile_screen/profile_scrfeen.dart';

Widget drawer() {
  return Drawer(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(25))),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      child: Column(
        children: [
           const ListTile(
          
            leading: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
            ),
          ),
          const CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage('assets/images/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Username',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.black,
            height: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          ListView(
            shrinkWrap: true,
            children: List.generate(
              draweIconsList.length,
              (index) => ListTile(
                onTap: () {
                  switch(index){
                    case 0:
                    Get.to(()=>const ProfileScreen(),transition: Transition.downToUp);
                  }
                },
                leading: Icon(draweIconsList[index]),
                title: drawListTitles[index],
              ),
            ),
          ),
           const SizedBox(
            height: 10,
          ),
          const ListTile(
            leading: Icon(inviteIcon),
          title: Text('Invite Friend'),
          ),
          const Spacer(),
          const ListTile(
            leading: Icon(logoutIcon),
            title: Text('Logout'),
          )
        ],
      ),
    ),
  );
}
