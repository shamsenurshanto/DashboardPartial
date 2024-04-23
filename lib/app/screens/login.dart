import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirupon_pos/app/routes/app_pages.dart';
import 'package:nirupon_pos/app/shared/widgets/appbar.dart';
import 'package:nirupon_pos/app/shared/widgets/background.dart';
import 'package:nirupon_pos/app/shared/widgets/button.dart';
import 'package:nirupon_pos/app/shared/widgets/custom_snackbar.dart';
import 'package:nirupon_pos/app/shared/widgets/text_input.dart';

import '../services/database/database_constants.dart';
import '../services/database/database_helper.dart';

class LoginView extends GetView<DrawerController> {

  LoginView({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(label: "Login"),
      body: Stack(
        children: [
          const Background(),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextInput(
                      label: "Username",
                      controller: usernameController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16.0),
                    TextInput(
                      label: "Password",
                      controller: passwordController,
                      textInputType: TextInputType.visiblePassword,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
                      child: Button(
                        onPressed: () async {
                          String username = usernameController.text.toString();
                          String password = passwordController.text.toString();
                          Map<String, dynamic>? user = await DatabaseHelper.instance.getUserByUsername(username);
                          if (user == null) {
                            CustomSnackBar.showCustomErrorSnackBar(title: "User not found", message: "Please register");
                            return;
                          }

                          if (user[DatabaseConstants.columnPassword] != password) {
                            CustomSnackBar.showCustomErrorSnackBar(title: "Password not matched", message: "Please enter correct password");
                            return;
                          }

                          await DatabaseHelper.instance.updateAllUserInfo(
                            row: {
                              DatabaseConstants.columnIsLoggedIn: 0
                            },
                          );

                          await DatabaseHelper.instance.updateUserInfo(
                            row: {
                              DatabaseConstants.columnIsLoggedIn: 1
                            },
                            username: username
                          );

                          CustomSnackBar.showCustomSnackBar(title: "Login Successful", message: "Please continue");
                          Get.offAndToNamed(Routes.DASHBOARD);
                        },
                        label: "LOGIN",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}