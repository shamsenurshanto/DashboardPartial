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

class RegistrationView extends GetView<DrawerController> {

  RegistrationView({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(label: "Registration"),
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
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
              child: Button(
                onPressed: () async {
                  String username = usernameController.text.toString();
                  String password = passwordController.text.toString();

                  await DatabaseHelper.instance.updateAllUserInfo(
                    row: {
                      DatabaseConstants.columnIsLoggedIn: 0
                    },
                  );

                  bool response = await DatabaseHelper.instance.insertUserInfo(row: {
                    DatabaseConstants.columnUsername: username,
                    DatabaseConstants.columnPassword: password,
                    DatabaseConstants.columnIsLoggedIn: 1
                  });

                  if (!response) {
                    CustomSnackBar.showCustomErrorSnackBar(title: "Registration failed", message: "Please try again later");
                    return;
                  }

                  if (response) {
                    CustomSnackBar.showCustomSnackBar(title: "Registration Successful", message: "Please continue");
                    Get.toNamed(Routes.BUSINESS_INFO);
                  }
                },
                label: "REGISTER",
              ),
            ),
          )
        ],
      ),
    );
  }
}