import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controller/home_controller.dart';
import 'package:threads_clone/widgets/loading.dart';
import 'package:threads_clone/widgets/post_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: () => controller.fetchPosts(),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: Obx(
                  () => controller.loading.value
                      ? const Loading()
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.posts.length,
                          itemBuilder: (context, index) =>
                              PostCard(post: controller.posts[index]),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
