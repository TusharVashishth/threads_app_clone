import 'package:get/get.dart';
import 'package:threads_clone/models/notification_model.dart';
import 'package:threads_clone/services/supabase_service.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel?> notifications = RxList<NotificationModel?>();
  var loading = false.obs;

  Future<void> fetchNotifications(String userId) async {
    loading.value = true;
    final List<dynamic> data =
        await SupabaseService.client.from("notifications").select('''
  id, post_id, notification,created_at , user_id ,user:user_id (email , metadata)
''').eq("to_user_id", userId).order("id", ascending: false);

    loading.value = false;
    if (data.isNotEmpty) {
      notifications.value = [
        for (var item in data) NotificationModel.fromJson(item)
      ];
    }
  }
}
