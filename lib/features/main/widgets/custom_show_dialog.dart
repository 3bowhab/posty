import 'package:flutter/material.dart';
import 'package:posty/core/extensions/responsive_padding_extension.dart';
import 'package:posty/l10n/app_localizations.dart';

class CustomShowDialog extends StatelessWidget {
  final String title;
  final String contentText;
  final VoidCallback onConfirm;
  const CustomShowDialog({
    super.key,
    required this.title,
    required this.contentText,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 5.horizontalPadding,
      child: InkWell(
        onTap: () async {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(contentText),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                TextButton(
                  onPressed: onConfirm,
                  child: Text(
                    AppLocalizations.of(context)!.confirm,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Icon(
          Icons.logout,
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
