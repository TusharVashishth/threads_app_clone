import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controller/auth_controller.dart';
import 'package:threads_clone/routes/route_names.dart';
import 'package:threads_clone/utils/styles/button_styles.dart';
import 'package:threads_clone/widgets/auth_input.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController cpasswordController =
      TextEditingController(text: "");
  final AuthController controller = Get.put(AuthController());

  // * Signup method
  void signUp() {
    if (_form.currentState!.validate()) {
      controller.register(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 60,
                  height: 60,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text("share your thoughts to world,"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AuthInput(
                  hintText: "Enter your name",
                  label: "Name",
                  controller: nameController,
                  callback:
                      ValidationBuilder().minLength(3).maxLength(50).build(),
                ),
                const SizedBox(height: 20),
                AuthInput(
                  hintText: "Enter your email",
                  label: "Email",
                  controller: emailController,
                  callback: ValidationBuilder().email().build(),
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthInput(
                  hintText: "Enter your password",
                  label: "Password",
                  controller: passwordController,
                  isPasswordField: true,
                  callback:
                      ValidationBuilder().minLength(6).maxLength(30).build(),
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthInput(
                  hintText: "Confirm your password",
                  label: "Confirm Password",
                  controller: cpasswordController,
                  isPasswordField: true,
                  callback: (arg) {
                    if (arg != passwordController.text) {
                      return "Confirm password not matched.";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => ElevatedButton(
                    style: authButtonStyle(
                        controller.registerLoading.value
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,
                        Colors.black),
                    onPressed: () => {
                      if (!controller.registerLoading.value)
                        {
                          signUp(),
                        }
                    },
                    child: Text(controller.registerLoading.value
                        ? "Processing.."
                        : "Submit"),
                  ),
                ),
                const SizedBox(height: 20),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: " Login",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.toNamed(RouteNames.login)),
                ], text: "Don't have an account ?"))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
