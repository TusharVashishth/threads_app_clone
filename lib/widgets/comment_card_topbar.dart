import 'package:flutter/material.dart';
import 'package:threads_clone/models/comment_model.dart';
import 'package:threads_clone/utils/helper.dart';

class CommentCardTopbar extends StatelessWidget {
  final CommentModel comment;
  const CommentCardTopbar({required this.comment, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          comment.user!.metadata!.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(formateDateFromNow(comment.createdAt!)),
            const SizedBox(width: 10),
            const Icon(Icons.more_horiz),
          ],
        )
      ],
    );
  }
}
