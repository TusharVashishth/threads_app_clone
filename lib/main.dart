import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:threads_clone/routes/route_names.dart';
import 'package:threads_clone/routes/routes.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/utils/storage/storage.dart';
import 'package:threads_clone/utils/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  Get.put(SupabaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Threads',
      theme: theme,
      getPages: Routes.routes,
      defaultTransition: Transition.noTransition,
      initialRoute:
          Storage.userSession != null ? RouteNames.home : RouteNames.login,
    );
  }
}
