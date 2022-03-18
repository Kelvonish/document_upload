import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upload/utils/text_styles.dart';

successSnackBar(String message) {
  Get.rawSnackbar(
      snackPosition: SnackPosition.BOTTOM,
      messageText: Text(
        message,
        style: bodyStyleWhite,
        maxLines: 5,
      ),
      margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
      backgroundColor: Colors.green,
      icon: const Icon(
        Icons.task_alt_outlined,
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16));
}

failureSnackBar(String message) {
  Get.rawSnackbar(
      snackPosition: SnackPosition.BOTTOM,
      messageText: Text(
        message,
        style: bodyStyleWhite,
        maxLines: 5,
      ),
      margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
      backgroundColor: Colors.red,
      icon: const Icon(
        Icons.highlight_off_outlined,
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16));
}

noInternetSnackBar() {
  Get.rawSnackbar(
      messageText: Text(
        "No internet connection",
        style: bodyStyleWhite,
        maxLines: 5,
      ),
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      icon: const Icon(
        Icons.cloud_off_outlined,
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16));
}
