import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String value)? onChange;
  final String? label;
  final String? hintTextInput;
  final String? errorText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool outlined;
  final bool? enabled;

  const TextInput({
    super.key,
    this.controller,
    this.onChange,
    this.label,
    this.errorText,
    this.textInputType,
    this.textInputAction,
    this.hintTextInput,
    this.outlined = false,
    this.enabled
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      cursorColor: Colors.pinkAccent,
      style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
      onChanged: onChange,
      keyboardType: textInputType,
      textInputAction: textInputAction ?? TextInputAction.done,
      obscureText: textInputType == TextInputType.visiblePassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[400],
        label: Text(label ?? ""),
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.pinkAccent),
        floatingLabelStyle: const TextStyle(
          color: Colors.pinkAccent,
          fontSize: 20
        ),
        errorText: errorText,
        errorStyle: const TextStyle(color: Colors.redAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: const Color.fromARGB(100, 230, 127, 161), width: 1.0),
        ),
        errorBorder: outlined ? OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.circular(4)
        ) : UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent), borderRadius: BorderRadius.circular(4)
        ),
        focusedErrorBorder: outlined ? OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(4)
        ) : UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(4)
        ),
      ),
    );
  }
}
