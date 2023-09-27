import 'dart:io';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/models/comment_model.dart';
import 'package:threads_clone/models/post_model.dart';
import 'package:threads_clone/models/user_model.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/utils/env.dart';
import 'package:threads_clone/utils/helper.dart';

class ProfileController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  var loading = false.obs;
  RxList<PostModel> posts = RxList<PostModel>();
  var postLoading = false.obs;
  var replyLoading = false.obs;
  RxList<CommentModel?> comments = RxList<CommentModel?>();
  var userLoading = false.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);

  // * Fetch user posts
  Future<void> fetchPosts(String userId) async {
    postLoading.value = true;
    final List<dynamic> data =
        await SupabaseService.client.from("posts").select('''
    id ,content , image ,created_at ,comment_count,like_count,
    user:user_id (email , metadata), likes:likes (user_id ,post_id)
''').eq("user_id", userId).order("id", ascending: false);

    postLoading.value = false;
    if (data.isNotEmpty) {
      posts.value = [for (var item in data) PostModel.fromJson(item)];
    }
  }

  // * Fetch user replies
  Future<void> fetchComments(String userId) async {
    replyLoading.value = true;
    final List<dynamic> data =
        await SupabaseService.client.from("comments").select('''
        id , user_id , post_id ,reply ,created_at ,user:user_id (email , metadata)
''').eq("user_id", userId).order("id", ascending: false);
    replyLoading.value = false;
    comments.value = [for (var item in data) CommentModel.fromJson(item)];
  }

  // * get user
  Future<void> getUser(String userId) async {
    userLoading.value = true;
    var data = await SupabaseService.client
        .from("users")
        .select("*")
        .eq("id", userId)
        .single();
    userLoading.value = false;
    user.value = UserModel.fromJson(data);

    // * Fetch posts and comments
    fetchPosts(userId);
    fetchComments(userId);
  }

  Future<void> updateProfile(String userId, String description) async {
    try {
      loading.value = true;

      // * Check if image exits then upload it first
      if (image.value != null && image.value!.existsSync()) {
        final String dir = "$userId/profile.jpg";
        final String path =
            await SupabaseService.client.storage.from(Env.s3Bucket).upload(
                  dir,
                  image.value!,
                  fileOptions: const FileOptions(upsert: true),
                );
        await SupabaseService.client.auth.updateUser(
          UserAttributes(
            data: {"image": path},
          ),
        );
      }

      // * Update description
      await SupabaseService.client.auth.updateUser(
        UserAttributes(
          data: {
            "description": description,
          },
        ),
      );

      loading.value = false;
      showSnackBar("Success", "Profile update successfully!");
    } on AuthException catch (error) {
      loading.value = false;
      showSnackBar("Error", error.message);
    } on StorageException catch (error) {
      loading.value = false;
      showSnackBar("Error", error.message);
    }
  }

  // * Delete thread
  Future<void> deleteThread(int postId) async {
    try {
      await SupabaseService.client.from("posts").delete().eq("id", postId);

      posts.removeWhere((element) => element.id == postId);
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      showSnackBar("Success", "thread deleted successfully!");
    } catch (e) {
      showSnackBar("Error", "Something went wrong.pls try again.");
    }
  }

  // * Delete thread
  Future<void> deleteReply(int replyId) async {
    try {
      await SupabaseService.client.from("comments").delete().eq("id", replyId);

      comments.removeWhere((element) => element?.id == replyId);
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      showSnackBar("Success", "Reply deleted successfully!");
    } catch (e) {
      showSnackBar("Error", "Something went wrong.pls try again.");
    }
  }

  // * Image picker
  void pickImage() async {
    File? file = await pickImageFromGallary();
    if (file != null) image.value = file;
  }
}
