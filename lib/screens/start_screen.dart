import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zchatapp/screens/verfication_screen.dart';
import '../controllers/auth_controller.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/2022-11-29-12-48-03-103.jpg'),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    child: SizedBox(
                      width: 300,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 18, 140, 126),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Get.to(() => const VerificationScreen());
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const VerificationScreen(),
                          // ));
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
