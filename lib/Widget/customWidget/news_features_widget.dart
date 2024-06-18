import 'package:flutter/material.dart';

class NewsFeatureWidget extends StatelessWidget {
  final IconData iconData;
  final Color? iconColor;
  final String? labelText;
  final int? value;
  final VoidCallback onPressed;

  const NewsFeatureWidget({
    Key? key,
    required this.iconData,
    required this.iconColor,
    this.labelText,
    this.value,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensure the column occupies minimum space
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            iconData,
            color: iconColor,
          ),
        ),
        SizedBox(height: 4), // Add some spacing between icon and text
        if (labelText != null)
          Text(labelText ?? ''),
        if (labelText == null)
          Text(value?.toString() ?? "0"),
      ],
    );
  }
}
