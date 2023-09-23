import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controller/thread_controller.dart';
import 'package:threads_clone/services/navigation_service.dart';
import 'package:threads_clone/services/supabase_service.dart';

class AddThreadAppBar extends StatelessWidget {
  const AddThreadAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xff242424)),
        ),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.find<NavigationService>().backToPrevIndex();
                },
                icon: const Icon(Icons.close),
              ),
              const SizedBox(width: 10),
              const Text(
                "New thread",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Obx(
            () => TextButton(
              onPressed: () => {
                Get.find<ThreadController>()
                    .store(Get.find<SupabaseService>().currentUser.value!.id),
              },
              child: Get.find<ThreadController>().loading.value
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Text(
                      "Post",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            Get.find<ThreadController>().content.value.length >
                                    1
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
