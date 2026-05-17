import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CreateOrDontHaveAccount extends StatelessWidget {
  final String text;
  final String textButton;
  final VoidCallback onTap;
  const CreateOrDontHaveAccount({super.key, required this.text, required this.textButton, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            TextSpan(
              text: textButton,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationColor: Theme.of(context).colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
