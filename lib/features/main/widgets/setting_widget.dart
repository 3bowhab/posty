import 'package:flutter/material.dart';
import 'package:posty/core/extensions/responsive_padding_extension.dart';
import 'package:posty/core/extensions/responsive_size_extension.dart';

class SettingWidget extends StatelessWidget {
  final String title;
  final Widget trailing;
  const SettingWidget({super.key, required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.height,
      padding: 16.horizontalPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          Spacer(),
          trailing,
        ],
      ),
    );
  }
}
