import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zchatapp/controllers/auth_controller.dart';
import 'package:zchatapp/screens/verfication_screen.dart';

class StartScreen extends StatelessWidget {
   const StartScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.white,
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
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  VerificationScreen(),));
                        },
                        child: const Text('Continue'),
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
