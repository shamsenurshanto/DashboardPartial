import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../translations/strings_enum.dart';
import '../utils/app_logger.dart';

class SelectImageModal {

  void pickFromCamera(Function(String image) updateImage) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        final imageFile = File(pickedImage.path);
        updateImage(imageFile.path);
      }
    } catch (e) {
      AppLogger.instance.error(e);
    }
  }

  void pickFromGallery(Function(String image) updateImage) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        File imageFile = File(pickedImage.path);
        updateImage(imageFile.path);
      }
    } catch (e) {
      AppLogger.instance.error(e);
    }
  }

  void showModal(BuildContext context, Function(String image) updateImage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.select.tr),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () {
                    pickFromCamera(updateImage);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      Strings.pickCamera.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () {
                    pickFromGallery(updateImage);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      Strings.pickGallery.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(Strings.close.tr),
            ),
          ],
        );
      },
    );
  }
}