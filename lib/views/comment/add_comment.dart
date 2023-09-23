import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controller/comment_controller.dart';
import 'package:threads_clone/models/post_model.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/widgets/circle_image.dart';
import 'package:threads_clone/widgets/post_image.dart';

class AddComment extends StatefulWidget {
  const AddComment({super.key});

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final PostModel post = Get.arguments;
  final CommentController controller = Get.put(CommentController());
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  void addReply() {
    if (controller.replyController.text.isNotEmpty) {
      controller.addReply(
        supabaseService.currentUser.value!.id,
        post.id!,
        post.userId!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.close)),
        title: const Text(
          "Reply",
        ),
        actions: [
          TextButton(
            onPressed: addReply,
            child: Obx(
              () => controller.loading.value
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      "Reply",
                      style: TextStyle(
                        fontWeight: controller.reply.value.isNotEmpty
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CircleImage(url: post.user?.metadata?.image),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.user!.metadata!.name!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(post.content!),
                  // Display the post image if has any
                  if (post.image != null)
                    PostImage(postId: post.id!, url: post.image!),
                  TextField(
                    autofocus: true,
                    controller: controller.replyController,
                    onChanged: (value) => controller.reply.value = value,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 10,
                    minLines: 1,
                    maxLength: 1000,
                    decoration: InputDecoration(
                      hintText: "Reply to ${post.user!.metadata!.name!}",
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
