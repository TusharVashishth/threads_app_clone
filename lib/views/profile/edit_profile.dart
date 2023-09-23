import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controller/profile_controller.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/widgets/circle_image.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  final ProfileController profileController = Get.find<ProfileController>();
  final TextEditingController textEditingController =
      TextEditingController(text: "");

  @override
  void initState() {
    textEditingController.text =
        supabaseService.currentUser.value?.userMetadata?["description"] ?? "";
    super.initState();
  }

  @override
  void dispose() {
    profileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
        actions: [
          Obx(() => TextButton(
                onPressed: () {
                  profileController.updateProfile(
                    supabaseService.currentUser.value!.id,
                    textEditingController.text,
                  );
                },
                child: profileController.loading.value
                    ? const SizedBox(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator.adaptive())
                    : const Text(
                        "Done",
                        style: TextStyle(fontSize: 16),
                      ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => Center(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    if (profileController.image.value != null)
                      CircleImage(
                        path: profileController.image.value,
                        radius: 70,
                      )
                    else
                      CircleImage(
                        url: supabaseService
                            .currentUser.value?.userMetadata?["image"],
                        radius: 70,
                      ),
                    CircleAvatar(
                      backgroundColor: Colors.white60,
                      child: IconButton(
                        onPressed: () {
                          profileController.pickImage();
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: textEditingController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Enter your description",
                label: Text("Description"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
