import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/models/user_model.dart';
import 'package:threads_clone/routes/route_names.dart';
import 'package:threads_clone/utils/helper.dart';
import 'package:threads_clone/widgets/circle_image.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: CircleImage(url: user.metadata?.image),
      ),
      title: Text(user.metadata!.name!),
      titleAlignment: ListTileTitleAlignment.top,
      trailing: OutlinedButton(
        onPressed: () {
          Get.toNamed(RouteNames.showProfile, arguments: user.id!);
        },
        child: const Text("View profile"),
      ),
      subtitle: Text(formateDateFromNow(user.createdAt!)),
    );
  }
}
