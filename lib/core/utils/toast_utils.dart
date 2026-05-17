import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastUtils {
  static void showSuccessToast(String message, BuildContext context) {
    debugPrint('Showing success toast: $message');
    toastification.show(
      context: context,
      type: ToastificationType.success,
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

  static void showErrorToast(String message, BuildContext context) {
    debugPrint('Showing error toast: $message');
    toastification.show(
      context: context,
      type: ToastificationType.error,
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

  static void showWarningToast(String message, BuildContext context) {
    debugPrint('Showing warning toast: $message');
    toastification.show(
      context: context,
      type: ToastificationType.warning,
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