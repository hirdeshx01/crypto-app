import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String label; // Add a label property

  const CustomButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.label, // Initialize the label property
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.filledTonal(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          icon: Icon(icon),
          onPressed: onPressed,
        ),
        const SizedBox(height: 4), // Add some spacing between the icon and text
        Text(label), // Add the text below the icon button
      ],
    );
  }
}
