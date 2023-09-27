import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controller/thread_controller.dart';
import 'package:threads_clone/widgets/comment_card.dart';
import 'package:threads_clone/widgets/loading.dart';
import 'package:threads_clone/widgets/post_card.dart';

class ShowThread extends StatefulWidget {
  const ShowThread({super.key});

  @override
  State<ShowThread> createState() => _ShowThreadState();
}

class _ShowThreadState extends State<ShowThread> {
  final int postId = Get.arguments;
  final ThreadController controller = Get.put(ThreadController());

  @override
  void initState() {
    controller.show(postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thread"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () => controller.showPostLoading.value
              ? const Loading()
              : Column(
                  children: [
                    PostCard(post: controller.post.value),

                    const SizedBox(height: 20),
                    // * load thread comments
                    if (controller.commentLoading.value)
                      const Loading()
                    else if (controller.comments.isNotEmpty &&
                        controller.commentLoading.value == false)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.comments.length,
                        itemBuilder: (context, index) =>
                            CommentCard(comment: controller.comments[index]!),
                      )
                    else
                      const Text("No replies")
                  ],
                ),
        ),
      ),
    );
  }
}
