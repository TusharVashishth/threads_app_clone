import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controller/auth_controller.dart';
import 'package:threads_clone/routes/route_names.dart';
import 'package:threads_clone/utils/styles/button_styles.dart';
import 'package:threads_clone/widgets/auth_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final AuthController controller = Get.put(AuthController());
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  void login() {
    if (_form.currentState!.validate()) {
      if (!controller.loginLoading.value) {
        controller.login(emailController.text, passwordController.text);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text("Welcome back,"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => ElevatedButton(
                    style: authButtonStyle(
                      controller.loginLoading.value
                          ? Colors.white.withOpacity(0.6)
                          : Colors.white,
                      Colors.black,
                    ),
                    onPressed: login,
                    child: Text(controller.loginLoading.value
                        ? "Processing..."
                        : "Submit"),
                  ),
                ),
                const SizedBox(height: 20),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: " Sign up",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.toNamed(RouteNames.register)),
                ], text: "Don't have an account ?"))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
