import 'package:get/get.dart';
import 'package:threads_clone/routes/route_names.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/utils/storage/storage.dart';
import 'package:threads_clone/utils/storage/storage_key.dart';

class SettingController extends GetxController {
  void logout() async {
    Storage.session.remove(StorageKey.session);
    SupabaseService.client.auth.signOut();

    Get.offAllNamed(RouteNames.login);
  }
}
