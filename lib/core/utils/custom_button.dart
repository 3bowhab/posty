import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
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
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderSideColor ?? Colors.transparent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 8)],
          labelWidget ??
              Text(
                label ?? '',
                style: theme.textTheme.titleMedium!.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ],
      ),
    );
  }
}
