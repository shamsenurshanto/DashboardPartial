import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import '../../modules/dashboard/controllers/dashboard_controller.dart';
import '../../routes/app_pages.dart';
import '../theme/my_theme.dart';
import '../theme/theme_extensions/header_container_theme_data.dart';
import '../translations/localization_service.dart';
import '../translations/strings_enum.dart';

class MyDrawer extends GetView<DrawerController> {

   const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Obx(() => ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.primaryColor,
              ),
              child: Text(Strings.hello.tr, style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white)),
            ),
            // ListTile(
            //   selected: controller.selectedItem.value == Routes.PROFILE,
            //   title: Text(Strings.profile.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
            //   leading: const Icon(Icons.person_2_rounded),
            //   onTap: () {
            //     Get.toNamed(Routes.PROFILE);
            //     controller.changeSelectedItem(Routes.PROFILE);
            //     controller.closeDrawer();
            //   },
            // ),
            // ListTile(
            //   selected: controller.selectedItem.value == Routes.PIN_CHNAGE,
            //   title: Text(Strings.changePin.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
            //   leading: const Icon(Icons.change_circle),
            //   onTap: () {
            //     Get.toNamed(Routes.PIN_CHNAGE);
            //     controller.changeSelectedItem(Routes.PIN_CHNAGE);
            //     controller.closeDrawer();
            //   },
            // ),
            // ListTile(
            //   title: Text(Strings.logout.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
            //   leading: const Icon(Icons.logout),
            //   onTap: controller.closeDrawer,
            // ),
            InkWell(
              onTap: () => MyTheme.changeTheme(),
              child: Ink(
                child: Container(
                  height: 39.h,
                  width: 39.h,
                  margin: const EdgeInsets.all(8.0),
                  decoration: theme.extension<HeaderContainerThemeData>()?.decoration,
                  child: SvgPicture.asset(
                    Get.isDarkMode ? 'assets/vectors/moon.svg' : 'assets/vectors/sun.svg',
                    fit: BoxFit.none,
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => LocalizationService.updateLanguage(
                LocalizationService.getCurrentLocal().languageCode == 'bn' ? 'en' : 'bn',
              ),
              child: Ink(
                child: Container(
                  height: 39.h,
                  width: 39.h,
                  margin: const EdgeInsets.all(8.0),
                  decoration: theme.extension<HeaderContainerThemeData>()?.decoration,
                  child: SvgPicture.asset(
                    'assets/vectors/language.svg',
                    fit: BoxFit.none,
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
