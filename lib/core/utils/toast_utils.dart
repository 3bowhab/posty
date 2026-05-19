import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastUtils {
  static void showSuccessToast(String message, BuildContext context) {
    debugPrint('Showing success toast: $message');
    _showToast(message, context, ToastificationType.success);
  }

  static void showErrorToast(String message, BuildContext context) {
    debugPrint('Showing error toast: $message');
    _showToast(message, context, ToastificationType.error);
  }

  static void showWarningToast(String message, BuildContext context) {
    debugPrint('Showing warning toast: $message');
    _showToast(message, context, ToastificationType.warning);
  }

  static void _showToast(
    String message,
    BuildContext context,
    ToastificationType type,
  ) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.fillColored,
      description: Text(message),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 4),
      animationBuilder: (context, animation, alignment, child) {
        return ScaleTransition(scale: animation, child: child);
      },
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: lowModeShadow,
      showProgressBar: true,
      applyBlurEffect: true,
    );
  }
}
