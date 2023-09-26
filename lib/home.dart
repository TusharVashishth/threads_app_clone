import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/services/navigation_service.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final NavigationService navigationService = Get.put(NavigationService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: navigationService.currentIndex.value,
          onDestinationSelected: (value) =>
              navigationService.updateIndex(value),
          animationDuration: const Duration(milliseconds: 500),
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.grey,
              ),
              label: "home",
              selectedIcon: Icon(
                Icons.home,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.search_outlined,
                color: Colors.grey,
              ),
              label: "search",
              selectedIcon: Icon(
                Icons.search,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.add_outlined,
                color: Colors.grey,
              ),
              label: "add",
              selectedIcon: Icon(
                Icons.add,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.favorite_border_outlined,
                color: Colors.grey,
              ),
              label: "Notification",
              selectedIcon: Icon(
                Icons.favorite,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_outline,
                color: Colors.grey,
              ),
              label: "Notification",
              selectedIcon: Icon(
                Icons.person,
              ),
            ),
          ],
        ),
      ),
      body: Obx(() => AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.ease,
            switchOutCurve: Curves.easeInOut,
            child:
                navigationService.pages()[navigationService.currentIndex.value],
          )),
    );
  }
}
