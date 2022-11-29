import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zchatapp/const/firebase.dart';
import 'package:zchatapp/controllers/auth_controller.dart';
import 'package:zchatapp/controllers/home_controller.dart';
import 'package:zchatapp/screens/compose_screen/compose_screen.dart';
import 'package:zchatapp/screens/homescreen/components/appbar.dart';
import 'package:zchatapp/screens/homescreen/components/drawer.dart';
import 'package:zchatapp/screens/homescreen/components/tab_bar-view.dart';
import 'package:zchatapp/screens/homescreen/components/tab_bar.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  final scaffoldKey =GlobalKey<ScaffoldState>();
  var controller =Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: scaffoldKey,
          drawer: drawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
            // print(auth.currentUser!.uid);
              Get.to(()=>const ComposeScreen(),transition: Transition.downToUp );
            },
            backgroundColor:  const Color.fromARGB(255, 18, 140, 126),
            child: const Icon(Icons.add,
            color: Colors.white,),
          ),
          backgroundColor: Colors.black,
          body: Container(
            color: Colors.white,
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    appbar(scaffoldKey),
                    tabbar(),
                    tabbarView(),
          
                    //    const Text('Home'),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     AuthController().logout();
                    //   },
                    //   child: const Text('Logout'),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
