import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAheadTextInput<T> extends StatelessWidget {
  final TextEditingController? controller;
  final Widget Function(BuildContext context, T value) item;
  final void Function(T value)? onSelected;
  final FutureOr<List<T>?> Function(String value) suggestionsCallback;
  final String? label;
  final String? hintTextInput;
  final String? errorText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool outlined;
  final bool? enabled;

  const TypeAheadTextInput({
    super.key,
    this.controller,
    required this.item,
    this.onSelected,
    required this.suggestionsCallback,
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
    return TypeAheadField<T>(
      itemBuilder: item,
      suggestionsCallback: suggestionsCallback,
      onSelected: onSelected,
      builder: (context, _, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          // autofocus: true,
          cursorColor: Colors.pinkAccent,
          style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[400],
            labelText: label,
            labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.pinkAccent),
            floatingLabelStyle: const TextStyle(
              color: Colors.pinkAccent,
              fontSize: 20
            ),
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
          )
        );
      },
    );
  }
}
