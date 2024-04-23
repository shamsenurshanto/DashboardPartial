import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String label;

  const CustomAppbar({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(label),
      centerTitle: true,
    );
  }
}
