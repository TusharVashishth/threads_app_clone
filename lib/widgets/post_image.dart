import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/routes/route_names.dart';
import 'package:threads_clone/utils/helper.dart';
import 'package:threads_clone/views/thread/show_image.dart';

class PostImage extends StatelessWidget {
  final String url;
  final int postId;
  const PostImage({required this.postId, required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteNames.showImage, arguments: url);
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.height * 0.60,
          minWidth: context.width * 0.80,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            getS3Url(url),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
