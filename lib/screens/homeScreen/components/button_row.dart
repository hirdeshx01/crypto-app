import 'package:ampiy_homepage/screens/homeScreen/components/custom_button.dart';
import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          icon: Icons.attach_money_rounded,
          onPressed: () {},
          label: 'Buy',
        ),
        CustomButton(
          icon: Icons.swap_vert_rounded,
          onPressed: () {},
          label: 'Swap',
        ),
        CustomButton(
          icon: Icons.arrow_upward_rounded,
          onPressed: () {},
          label: 'Send',
        ),
        CustomButton(
          icon: Icons.arrow_downward_rounded,
          onPressed: () {},
          label: 'Receive',
        )
      ],
    );
  }
}
