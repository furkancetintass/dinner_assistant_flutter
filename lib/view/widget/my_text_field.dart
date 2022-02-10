import 'package:flutter/material.dart';

TextFormField buildTextField(
    {required String label,
    required TextEditingController controller,
    Widget? icon,
    context,
    int? maxLines,
    bool? isObsecture,
    bool? readOnly}) {
  return TextFormField(
    obscureText: isObsecture ?? false,
    controller: controller,
    maxLines: maxLines ?? 1,
    readOnly: readOnly ?? false,
    decoration: InputDecoration(
      icon: icon,
      labelText: label,
    ),
  );
}
