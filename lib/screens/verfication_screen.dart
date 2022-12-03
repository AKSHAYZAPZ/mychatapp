import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:zchatapp/const/firebase.dart';
import '../controllers/auth_controller.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 18, 140, 126),
        title: const Text(
          "Let's connect",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: AuthController.instance.formKey,
              child: Column(
                children: [
                  const Text(
                    'Sign up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromARGB(255, 18, 140, 126),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter username';
                      } else if (value.length <= 4) {
                        return 'username should minimum 5 charecters';
                      }
                      return null;
                    },
                    controller: AuthController.instance.usernameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.account_box),
                      labelText: 'User Name',
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter PhoneNumber';
                      } else if (value.length <= 9) {
                        return 'Please enter valid Phonenumber';
                      }
                      return null;
                    },
                    controller: AuthController.instance.phoneController,
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
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'We will send an SMS with a confirmation code to your phonenumber',
            ),
            Obx(
              () => Visibility(
                visible: AuthController.instance.isOtpSent.value,
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
                          controller:
                              AuthController.instance.otpController[index],
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            if (value.length == 1 && index <= 5) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isNotEmpty && index > 0) {
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
                    primary: const Color.fromARGB(255, 18, 140, 126),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () async {
                    if (AuthController.instance.formKey.currentState!
                        .validate()) {
                      if (AuthController.instance.isOtpSent.value == false) {
                        AuthController.instance.isOtpSent.value = true;

                        await AuthController.instance.sendOtp(
                            AuthController.instance.phoneController.text);
                      } else {
                        await AuthController.instance.verfyOtp(
                          AuthController.instance.usernameController.text,
                          AuthController.instance.phoneController.text,
                        );
                        // print('else worked');

                      }
                    }

                    // print(controller.phoneController.text);
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
    );
  }
}
