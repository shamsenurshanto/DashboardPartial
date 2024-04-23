import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundCornerImage extends StatelessWidget {

  final String? imageLink;
  final VoidCallback? onTap;

  const RoundCornerImage({super.key, this.imageLink, this.onTap});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
     double roundedVal = 13;
     var valueWidth = 130 ;
    return Stack(
      children: [
        Positioned(
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              height: ScreenUtil().setHeight(valueWidth),
              width: ScreenUtil().setWidth(valueWidth),             
              child: SizedBox(
                height: ScreenUtil().setHeight(valueWidth),
                width: ScreenUtil().setWidth(valueWidth),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(valueWidth/2), // Adjust the radius as needed
                  child: imageLink == null || imageLink!.isEmpty
                  ? const Icon(Icons.person,size: 130,)
                  : Image.file(
                    File(imageLink!),
                    fit: BoxFit.cover, // Choose the desired BoxFit value
                  ),
                ),
              )
            ),
          ),
        ),
        Positioned(
          top: ScreenUtil().setHeight(35),
          left: ScreenUtil().setWidth(200),
          child: Container(
            width: ScreenUtil().setWidth(35),
            height: ScreenUtil().setHeight(35),
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(50)
            ),
            child: GestureDetector(
              onTap: onTap,
              child: const Icon(
                Icons.add_a_photo_outlined,
                size: 27,
                color: Colors.white,
              ),
            )
          )
        )
      ],
    );
  }
}
