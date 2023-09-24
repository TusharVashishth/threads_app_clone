import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:threads_clone/utils/env.dart';
import 'package:threads_clone/widgets/confirm_box.dart';
import 'package:uuid/uuid.dart';

void showSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: const Color(0xff252526),
    colorText: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    snackStyle: SnackStyle.GROUNDED,
    margin: const EdgeInsets.all(0.0),
  );
}

// * Confirm box
void confirmBox(String title, String text, VoidCallback callback) {
  Get.dialog(
    ConfirmBox(
      title: title,
      text: text,
      callback: callback,
    ),
  );
}

// * Pick Image
Future<File?> pickImageFromGallary() async {
  const uuid = Uuid();
  final ImagePicker picker = ImagePicker();

  final XFile? file = await picker.pickImage(source: ImageSource.gallery);
  if (file == null) return null;
  final dir = Directory.systemTemp;
  final targetPath = "${dir.absolute.path}/${uuid.v6()}.jpg";
  File image = await compressImage(File(file.path), targetPath);
  return image;
}

// * Compress the image file
Future<File> compressImage(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.path,
    targetPath,
    quality: 70,
  );

  return File(result!.path);
}

// * Get Supabase s3 bucket url
String getS3Url(String path) {
  return "${Env.supabaseUrl}/storage/v1/object/public/$path";
}

// * formate date
String formateDateFromNow(String date) {
  // Parse UTC timestamp string to DateTime
  DateTime utcDateTime = DateTime.parse(date.split('+')[0].trim());

  // Convert UTC to IST (UTC+5:30 for Indian Standard Time)
  DateTime istDateTime = utcDateTime.add(const Duration(hours: 5, minutes: 30));

  // Format the DateTime using Jiffy
  return Jiffy.parseFromDateTime(istDateTime).fromNow();
}
