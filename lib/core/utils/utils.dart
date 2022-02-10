import 'package:dinner_assistant_flutter/view/widget/my_snackbar.dart';
import 'package:flutter/material.dart';

class Utils {
  showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(mySnackBar());
  }
  showErrorSnackBar(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(myErrorSnackBar(message));
  }
}
