import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirupon_pos/app/shared/utils/app_logger.dart';

import '../routes/app_pages.dart';
import '../services/database/database_constants.dart';
import '../services/database/database_helper.dart';
import '../services/global.dart';
import '../shared/widgets/background.dart';

class SplashScreen extends GetView<DrawerController> {

  bool isRegistered = false;
  bool isBusinessTypeSet = false;
  bool isBinSet = false;
  bool isOutletSet = false;
  bool isLoggedIn = false;

  SplashScreen({super.key});

  Future<bool> checkStatus() async {
    AppLogger.instance.logger.d('Checking status');
    Map<String, dynamic>? basicInfo = await DatabaseHelper.instance.getBasicInfo();
    Constants.binNo = basicInfo?[DatabaseConstants.columnBinNo];
    Constants.binHolderName = basicInfo?[DatabaseConstants.columnBinHolderName];
    if (
        basicInfo != null &&
        Constants.binHolderName != null &&
        Constants.binHolderName.toString().isNotEmpty
    ) {
      isBinSet = true;
    }

    Constants.businessType = basicInfo?[DatabaseConstants.columnBusinessType];
    if (
        basicInfo != null &&
        Constants.businessType != null &&
        Constants.businessType.toString().isNotEmpty
    ) {
      isBusinessTypeSet = true;
    }

    List<Map<String, dynamic>> userList = await DatabaseHelper.instance.getUserInfo();
    if (userList.isNotEmpty) isRegistered = true;

    List<Map<String, dynamic>> loggedInUserList = await DatabaseHelper.instance.getLoggedInUserList();
    if (loggedInUserList.isNotEmpty) isLoggedIn = true;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // const Background(),
          Center(
            child: FutureBuilder(
              future: checkStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  !isRegistered
                  ? Future.delayed(
                      Duration.zero,
                      () => Get.offAndToNamed(Routes.REGISTRATION)
                  )
                  : !isBusinessTypeSet
                  ? Future.delayed(
                  Duration.zero,
                      () => Get.toNamed(Routes.BUSINESS_INFO)
                  )
                  : !isBinSet
                  ? Future.delayed(
                      Duration.zero,
                      () => Get.toNamed(Routes.BIN_INFO)
                    )
                  : !isLoggedIn
                  ? Future.delayed(
                  Duration.zero,
                      () => Get.toNamed(Routes.LOGIN)
                  )
                  : Future.delayed(
                      Duration.zero,
                      () => Get.toNamed(Routes.DASHBOARD)
                  );
                }
                return Image.asset('assets/images/app_logo.webp');
              },
            ),
          ),
        ],
      ),
    );
  }
}
