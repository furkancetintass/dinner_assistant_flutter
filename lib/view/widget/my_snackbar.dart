import 'package:flutter/material.dart';

SnackBar mySnackBar() {
  return SnackBar(
      backgroundColor: Colors.green.shade700,
      content: const Text('İşleminiz başarılı bir şekilde gerçekleşmiştir.'));
}

SnackBar myErrorSnackBar(String message) {
  return SnackBar(
      backgroundColor: Colors.red.shade700,
      content:  Text(message));
}


