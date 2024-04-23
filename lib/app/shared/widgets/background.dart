import 'package:flutter/material.dart';

class Background extends StatelessWidget {

  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2), // Adjust opacity here
            BlendMode.darken, // Adjust blend mode as needed
          ),
        ),
      ),
    );
  }
}
