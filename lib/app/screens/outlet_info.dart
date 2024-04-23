import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirupon_pos/app/routes/app_pages.dart';
import 'package:nirupon_pos/app/shared/widgets/appbar.dart';
import 'package:nirupon_pos/app/shared/widgets/background.dart';
import 'package:nirupon_pos/app/shared/widgets/button.dart';
import 'package:nirupon_pos/app/shared/widgets/text_input.dart';

import '../services/database/database_constants.dart';
import '../services/database/database_helper.dart';
import '../shared/widgets/custom_snackbar.dart';

class OutletInfoView extends GetView<DrawerController> {

  OutletInfoView({super.key});

  final TextEditingController outletNameController = TextEditingController();
  final TextEditingController outletPhoneController = TextEditingController();
  final TextEditingController outletAddressLine1Controller = TextEditingController();
  final TextEditingController outletAddressLine2Controller = TextEditingController();
  final TextEditingController outletPostCodeController = TextEditingController();
  final TextEditingController outletCityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(label: "Outlet Information"),
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
                      label: "Outlet Name",
                      controller: outletNameController,
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16.0),
                    TextInput(
                      label: "Phone",
                      controller: outletPhoneController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16.0),
                    TextInput(
                      label: "Address Line 1",
                      controller: outletAddressLine1Controller,
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16.0),
                    TextInput(
                      label: "Address Line 2",
                      controller: outletAddressLine2Controller,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    TextInput(
                      label: "Post Code",
                      controller: outletPostCodeController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    TextInput(
                      label: "City",
                      controller: outletCityController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Button(
                            onPressed: () {
                              Get.offAndToNamed(Routes.DASHBOARD);
                            },
                            label: "SKIP",
                          ),
                          Button(
                            onPressed: () async {
                              String outletName = outletNameController.text.toString();
                              String outletPhone = outletPhoneController.text.toString();
                              String outletAddressLine1 = outletAddressLine1Controller.text.toString();
                              String outletAddressLine2 = outletAddressLine2Controller.text.toString();
                              String outletPostCode = outletPostCodeController.text.toString();
                              String outletCity = outletCityController.text.toString();
                              bool response = await DatabaseHelper.instance.updateBasicInfo(row: {
                                DatabaseConstants.columnOutletNameEn: outletName,
                                DatabaseConstants.columnOutletPhone: outletPhone,
                                DatabaseConstants.columnOutletAddressLine1: outletAddressLine1,
                                DatabaseConstants.columnOutletAddressLine2: outletAddressLine2,
                                DatabaseConstants.columnOutletCity: outletCity,
                              });
                              if (response) {
                                CustomSnackBar.showCustomSnackBar(title: "Outlet added", message: "Please continue");
                                Future.delayed(const Duration(seconds: 2), () {
                                  Get.offAndToNamed(Routes.DASHBOARD);
                                });
                              }
                            },
                            label: "NEXT",
                          )
                        ],
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