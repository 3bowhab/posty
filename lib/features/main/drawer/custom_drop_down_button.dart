import 'package:flutter/material.dart';
import 'package:posty/core/extensions/responsive_padding_extension.dart';
import 'package:posty/l10n/app_localizations.dart';

class CustomDropDownButton extends StatelessWidget {
  final String value;
  final List<String> list;
  final Function(String) onChanged;

  const CustomDropDownButton({
    super.key,
    required this.value,
    required this.list,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 8.horizontalPadding,
      child: Container(
        padding: 16.horizontalPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.arrow_drop_down),
          isExpanded: true,
          underline: const SizedBox(),
          dropdownColor: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          style: Theme.of(context).textTheme.titleSmall,
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
          items: list.map((item) {
            String displayedText = item;
            if (item == 'Light') {
              displayedText = AppLocalizations.of(context)!.light;
            } else if (item == 'Dark') {
              displayedText = AppLocalizations.of(context)!.dark;
            }

            return DropdownMenuItem(value: item, child: Text(displayedText));
          }).toList(),
        ),
      ),
    );
  }
}
