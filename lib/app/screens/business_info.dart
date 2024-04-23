import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirupon_pos/app/shared/utils/app_logger.dart';
import 'package:nirupon_pos/app/shared/widgets/appbar.dart';
import 'package:nirupon_pos/app/shared/widgets/background.dart';
import 'package:nirupon_pos/app/shared/widgets/button.dart';
import 'package:nirupon_pos/app/shared/widgets/text_input.dart';

import '../routes/app_pages.dart';
import '../services/database/database_constants.dart';
import '../services/database/database_helper.dart';
import '../shared/widgets/custom_snackbar.dart';
import '../shared/widgets/th_text_input.dart';

class BusinessInfoView extends GetView<DrawerController> {

  BusinessInfoView({super.key});

  final TextEditingController businessTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(label: "Business Information"),
      body: Stack(
        children: [
          const Background(),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TypeAheadTextInput<City>(
                      label: "Business Type",
                      controller: businessTypeController,
                      item: (BuildContext context, City city) {
                        return ListTile(
                          title: Text(city.title),
                          subtitle: Text(city.subtitle),
                        );
                      },
                      suggestionsCallback: (String value) {
                        return [
                          City("Restaurant", "AC without Bar"),
                          City("Restaurant", "AC with Bar"),
                          City("Restaurant", "Non-AC without Bar"),
                        ];
                      },
                      onSelected: (City city) {
                        AppLogger.instance.logger.d(city.title);
                        businessTypeController.text = "${city.title} (${city.subtitle})";
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
                      child: Button(
                        onPressed: () async {
                          String businessType = businessTypeController.text.toString();
                          bool response = await DatabaseHelper.instance.updateBasicInfo(row: {
                            DatabaseConstants.columnBusinessType: businessType,
                          });
                          if (response) {
                            CustomSnackBar.showCustomSnackBar(title: "Bin holder info added", message: "Please continue");
                            Get.toNamed(Routes.OUTLET_INFO);
                          }

                          CustomSnackBar.showCustomSnackBar(title: "Business type added", message: "Please continue");
                          Future.delayed(const Duration(seconds: 2), () {
                            Get.toNamed(Routes.BIN_INFO);
                          });
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

class City {
  String title;
  String subtitle;

  City(this.title, this.subtitle);
}