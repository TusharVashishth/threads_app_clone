import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controller/thread_controller.dart';

class ThreadImagePreview extends StatelessWidget {
  ThreadImagePreview({super.key});
  final ThreadController controller = Get.find<ThreadController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              controller.image.value!,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: CircleAvatar(
              backgroundColor: Colors.white38,
              child: IconButton(
                onPressed: () {
                  controller.image.value = File("");
                },
                icon: const Icon(Icons.close),
              ),
            ),
          )
        ],
      ),
    );
  }
}
