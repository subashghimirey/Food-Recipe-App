import 'package:flutter/material.dart';


class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.icon, required this.label});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 18,),
        const SizedBox(
          width: 6,
        ),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 15),),
      ],
    );
  }
}
