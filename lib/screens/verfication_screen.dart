import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../controllers/auth_controller.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({Key? key}) : super(key: key);

   final controller = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's  connect"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller.usernameController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.account_box),
                  labelText: 'User Name',
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey))),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: controller.phoneController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone_android_outlined),
                labelText: 'Phone Number',
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const Text(
              'We will send an SMS with a confirmation code to your phonenumber',
            ),
            Obx(() =>
            Visibility(
              visible: controller.isOtpSent.value,
              child: SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          height: 65,
                          width: 50,
                          child: TextField(

                            keyboardType: TextInputType.number,
                            controller: controller.otpController[index],
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if(value.length == 1 && index <= 5){
                                FocusScope.of(context).nextFocus();
                              }else if
                                (value.isNotEmpty && index >0){
                                  FocusScope.of(context).previousFocus();
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: '*'),
                          ),
                        ),
                      ),
                    ),
                  ),
            ),
              
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () async{
                   if(controller.isOtpSent.value == false){
                     controller.isOtpSent.value= true;
                    await controller.sendOtp(); 
                   }else{
                   await controller.verfyOtp();
                   print('else worked');
                   }
                   
                    // print(controller.phoneController.text);
                  },
                  child: const Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
