import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/models/post_model.dart';
import 'package:threads_clone/routes/route_names.dart';
import 'package:threads_clone/utils/type_def.dart';
import 'package:threads_clone/widgets/circle_image.dart';
import 'package:threads_clone/widgets/post_card_bottom_bar.dart';
import 'package:threads_clone/widgets/post_card_top_bar.dart';
import 'package:threads_clone/widgets/post_image.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isAuthPost;
  final DeleteCallback? callback;
  const PostCard(
      {required this.post, this.isAuthPost = false, this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: Column(
                children: [
                  CircleImage(url: post.user?.metadata?.image),
                ],
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menu bar
                  PostCardTopBar(
                    post: post,
                    isAuthPost: isAuthPost,
                    callback: callback,
                  ),
                  InkWell(
                    onTap: () =>
                        Get.toNamed(RouteNames.showThread, arguments: post.id),
                    child: Text(post.content!),
                  ),

                  // If image exist then show image
                  const SizedBox(height: 10),
                  if (post.image != null)
                    PostImage(postId: post.id!, url: post.image!),

                  // Post Bottom Bar
                  PostCardBottombar(post: post),
                ],
              ),
            )
          ],
        ),
        const Divider(
          color: Color(0xff242424),
        )
      ],
    );
  }
}
