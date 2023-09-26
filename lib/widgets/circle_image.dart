import 'dart:io';

import 'package:flutter/material.dart';
import 'package:threads_clone/utils/helper.dart';

class CircleImage extends StatelessWidget {
  final String? url;
  final File? path;
  final double radius;

  const CircleImage({
    this.url,
    this.path,
    this.radius = 20,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (path != null)
          CircleAvatar(
            radius: radius,
            backgroundImage: FileImage(path!),
          )
        else if (url != null)
          CircleAvatar(
            backgroundImage: NetworkImage(getS3Url(url!)),
            radius: radius,
          )
        else
          CircleAvatar(
            radius: radius,
            backgroundImage: const AssetImage("assets/images/avatar.png"),
          )
      ],
    );
  }
}
