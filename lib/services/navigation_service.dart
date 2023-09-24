import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:threads_clone/views/home/home_page.dart';
import 'package:threads_clone/views/notification/notification_page.dart';
import 'package:threads_clone/views/profile/profile.dart';
import 'package:threads_clone/views/search/search.dart';
import 'package:threads_clone/views/thread/add_thread.dart';

class NavigationService extends GetxService {
  RxInt currentIndex = 0.obs;
  RxInt previousIndex = 0.obs;

  void updateIndex(int index) {
    previousIndex.value = currentIndex.value;
    currentIndex.value = index;
  }

  void backToPrevIndex() {
    currentIndex.value = previousIndex.value;
  }

  List<Widget> pages() {
    return [
      const HomePage(),
      const Search(),
      AddThread(),
      const NotificationPage(),
      const Profile()
    ];
  }
}
