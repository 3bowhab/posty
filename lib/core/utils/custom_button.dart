import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? label;
  final Widget? labelWidget;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? borderSideColor;
  const CustomButton({
    super.key,
    required this.onPressed,
    this.label,
    this.icon,
    this.backgroundColor,
    this.borderSideColor,
    this.labelWidget,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: labelWidget != null
          ? labelWidget!
          : Text(
              label!,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold
              ),
            ),
      icon: icon ?? SizedBox.shrink(),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderSideColor ?? Colors.transparent),
      ),
    );
  }
}
