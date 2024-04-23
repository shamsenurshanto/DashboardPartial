import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final String? label;

  const Button({
    super.key,
    this.onPressed,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0)
      ),
      onPressed: onPressed,
      child: Text(label ?? "Next",
          style: const TextStyle(color: Colors.white, fontSize: 14)
      )
    );
  }
}
