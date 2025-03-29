import 'package:flutter/material.dart';

class ProjectSelectionSuccessText extends StatelessWidget {
  const ProjectSelectionSuccessText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check_box, color: Colors.green.shade300, size: 16),
        Text(
          'Is a Flutter Project',
          style: TextStyle(color: Colors.green.shade300),
        ),
      ],
    );
  }
}
