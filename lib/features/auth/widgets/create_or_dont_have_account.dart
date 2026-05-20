import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CreateOrDontHaveAccount extends StatelessWidget {
  final String text;
  final String textButton;
  final VoidCallback onTap;

  const CreateOrDontHaveAccount({
    super.key,
    required this.text,
    required this.textButton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            TextSpan(
              text: textButton,
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.primary,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationColor: theme.colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
