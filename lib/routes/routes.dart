import 'package:get/get.dart';
import 'package:threads_clone/home.dart';
import 'package:threads_clone/routes/route_names.dart';
import 'package:threads_clone/views/auth/login.dart';
import 'package:threads_clone/views/auth/register.dart';
import 'package:threads_clone/views/comment/add_comment.dart';
import 'package:threads_clone/views/profile/edit_profile.dart';
import 'package:threads_clone/views/profile/show_profile.dart';
import 'package:threads_clone/views/setting/setting.dart';
import 'package:threads_clone/views/thread/show_image.dart';
import 'package:threads_clone/views/thread/show_thread.dart';

class Routes {
  static final routes = [
    GetPage(name: RouteNames.home, page: () => Home()),
    GetPage(name: RouteNames.login, page: () => const Login()),
    GetPage(name: RouteNames.register, page: () => const Register()),
    GetPage(
      name: RouteNames.setting,
      page: () => Setting(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouteNames.editProfile,
      page: () => const EditProfile(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.addComment,
      page: () => const AddComment(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RouteNames.showThread,
      page: () => const ShowThread(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: RouteNames.showImage,
      page: () => ShowImage(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: RouteNames.showProfile,
      page: () => const ShowProfile(),
      transition: Transition.leftToRight,
    ),
  ];
}
