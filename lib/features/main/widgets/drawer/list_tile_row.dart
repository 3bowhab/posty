import 'package:flutter/material.dart';
import 'package:posty/core/extensions/responsive_sized_box_extension.dart';

class ListTileRow extends StatelessWidget {
  final IconData icon;
  final String title;

  const ListTileRow({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        8.horizontalSizedBox,
        Text(title, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
