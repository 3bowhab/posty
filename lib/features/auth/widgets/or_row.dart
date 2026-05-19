import 'package:flutter/material.dart';
import 'package:posty/core/extensions/responsive_sized_box_extension.dart';
import 'package:posty/core/theme/app_colors.dart';
import 'package:posty/l10n/app_localizations.dart';

class OrRow extends StatelessWidget {
  const OrRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildDivider(),
        10.horizontalSizedBox,
        Text(
          AppLocalizations.of(context)!.or,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppColors.textColor),
        ),
        10.horizontalSizedBox,
        _buildDivider(),
      ],
    );
  }

  Widget _buildDivider() {
    return const Expanded(
      child: Divider(color: AppColors.textColor, thickness: 2),
    );
  }
}
