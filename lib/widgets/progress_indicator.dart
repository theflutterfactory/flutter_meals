import 'package:flutter/material.dart';

class MealsProgressIndicator extends StatelessWidget {
  const MealsProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
