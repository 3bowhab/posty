import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context ) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}