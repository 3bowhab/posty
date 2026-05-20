import 'package:flutter/material.dart';
import 'package:posty/core/constants/app_routes.dart';
import 'package:posty/core/extensions/responsive_sized_box_extension.dart';
import 'package:posty/features/main/widgets/drawer/custom_drop_down_button.dart';
import 'package:posty/features/main/widgets/drawer/list_tile_row.dart';

class CustomListTile extends StatefulWidget {
  final List<String> list;
  final String title;
  final IconData icon;
  final String initialValue;
  final Function(String) onChanged;

  const CustomListTile({
    super.key,
    required this.list,
    required this.title,
    required this.icon,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        children: [
          ListTileRow(icon: widget.icon, title: widget.title),
          8.verticalSizedBox,
          CustomDropDownButton(
            value: dropdownValue,
            list: widget.list,
            onChanged: (value) {
              setState(() {
                dropdownValue = value;
              });
              widget.onChanged(value);
            },
          ),
        ],
      ),
      onTap: () {
        Navigator.pushReplacementNamed(context, AppRoutes.homeView);
      },
    );
  }
}
