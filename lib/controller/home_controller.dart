import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/models/post_model.dart';
import 'package:threads_clone/models/user_model.dart';
import 'package:threads_clone/services/supabase_service.dart';

class HomeController extends GetxController {
  RxList<PostModel> posts = RxList<PostModel>();
  var loading = false.obs;

  @override
  void onInit() async {
    await fetchPosts();
    listenPostChange();

    super.onInit();
  }

  Future<void> fetchPosts() async {
    loading.value = true;
    final List<dynamic> data =
        await SupabaseService.client.from("posts").select('''
    id ,content , image ,created_at ,comment_count , like_count,user_id,
    user:user_id (email , metadata) , likes:likes (user_id ,post_id)
''').order("id", ascending: false);
    loading.value = false;

    if (data.isNotEmpty) {
      posts.value = [for (var item in data) PostModel.fromJson(item)];
    }
  }

  // * Listen post changes
  void listenPostChange() {
    SupabaseService.client.channel('public:posts').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: 'INSERT', schema: 'public', table: 'posts'),
      (payload, [ref]) {
        final PostModel post = PostModel.fromJson(payload["new"]);
        updateFeed(post);
      },
    ).on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: 'DELETE', schema: 'public', table: 'posts'),
      (payload, [ref]) {
        posts.removeWhere((element) => element.id == payload["old"]["id"]);
      },
    ).subscribe();
  }

  // * update the home feed
  void updateFeed(PostModel post) async {
    var user = await SupabaseService.client
        .from("users")
        .select("*")
        .eq("id", post.userId)
        .single();

    // * Fetch likes
    post.likes = [];
    post.user = UserModel.fromJson(user);
    posts.insert(0, post);
  }
}
