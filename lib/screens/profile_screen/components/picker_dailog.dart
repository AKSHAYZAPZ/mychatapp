import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Widget pickerDialog(context, controller) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Source',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  onTap: () async {
                    controller.selectImage(context, ImageSource.camera);
                    Get.back();
                  },
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: const Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    controller.selectImage(context, ImageSource.gallery);
                    Get.back();
                  },
                  leading: const Icon(Icons.photo),
                  title: const Text('Gallery'),
                ),
                ListTile(
                  onTap: () {
                    Get.back();
                  },
                  leading: const Icon(Icons.cancel),
                  title: const Text('cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
