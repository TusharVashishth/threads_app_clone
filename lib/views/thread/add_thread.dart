import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controller/thread_controller.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/widgets/add_thread_appbar.dart';
import 'package:threads_clone/widgets/thread_image_preview.dart';

class AddThread extends StatelessWidget {
  AddThread({super.key});
  final ThreadController controller = Get.put(ThreadController());
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AddThreadAppBar(),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/avatar.png",
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: context.width - 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              supabaseService
                                  .currentUser.value!.userMetadata?["name"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextField(
                            autofocus: true,
                            controller: controller.contentController,
                            onChanged: (value) =>
                                controller.content.value = value,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 10,
                            minLines: 1,
                            maxLength: 1000,
                            decoration: const InputDecoration(
                              hintText: 'type a thread',
                              border: InputBorder.none, // Remove border
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: const Icon(Icons.attach_file),
                          ),
                          // * If user select image then show preview
                          Obx(
                            () => Column(
                              children: [
                                if (controller.image.value != null)
                                  ThreadImagePreview()
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
