import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirupon_pos/app/routes/app_pages.dart';
import 'package:nirupon_pos/app/services/database/database_constants.dart';
import 'package:nirupon_pos/app/services/database/database_helper.dart';
import 'package:nirupon_pos/app/shared/widgets/appbar.dart';
import 'package:nirupon_pos/app/shared/widgets/background.dart';
import 'package:nirupon_pos/app/shared/widgets/button.dart';
import 'package:nirupon_pos/app/shared/widgets/text_input.dart';

import '../shared/widgets/custom_snackbar.dart';

class BinInfoView extends GetView<DrawerController> {

  BinInfoView({super.key});

  final TextEditingController binNoController = TextEditingController();
  final TextEditingController binHolderNameController = TextEditingController();
  final TextEditingController binHolderPhoneController = TextEditingController();
  final TextEditingController binHolderEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(label: "Bin Holder Information"),
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
                      label: "Bin No",
                      controller: binNoController,
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16.0),
                    TextInput(
                      label: "Bin Holder Name",
                      controller: binHolderNameController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16.0),
                    TextInput(
                      label: "Phone",
                      controller: binHolderPhoneController,
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16.0),
                    TextInput(
                      label: "Email",
                      controller: binHolderEmailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
                      child: Button(
                        onPressed: () async {
                          String binNo = binNoController.text.toString();
                          String binHolderName = binHolderNameController.text.toString();
                          String binHolderPhone = binHolderPhoneController.text.toString();
                          String binHolderEmail = binHolderEmailController.text.toString();
                          bool response = await DatabaseHelper.instance.updateBasicInfo(row: {
                            DatabaseConstants.columnBinHolderName: binHolderName,
                            DatabaseConstants.columnBinHolderPhone: binHolderPhone,
                            DatabaseConstants.columnBinHolderEmail: binHolderEmail,
                            DatabaseConstants.columnBinNo: binNo,
                          });
                          if (response) {
                            CustomSnackBar.showCustomSnackBar(title: "Bin holder info added", message: "Please continue");
                            Get.toNamed(Routes.OUTLET_INFO);
                          }
                        },
                        label: "NEXT",
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