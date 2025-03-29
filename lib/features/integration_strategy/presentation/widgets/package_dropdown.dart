import 'package:flutter/material.dart';

import '../../../../common/supported_package.dart';

class PackagesDropdown extends StatelessWidget {
  const PackagesDropdown({
    super.key,
    required this.items,
    this.selectedValue,
    required this.onChanged,
  });

  final List<SupportedPackage> items;
  final SupportedPackage? selectedValue;
  final ValueChanged<SupportedPackage?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2,
      child: DropdownButtonFormField<SupportedPackage>(
        value: selectedValue,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          label: Text('Select package'),
        ),
        items:
            items.map((item) {
              return DropdownMenuItem(value: item, child: Text(item.text));
            }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
