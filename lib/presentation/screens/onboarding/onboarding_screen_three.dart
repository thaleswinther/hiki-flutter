import 'package:flutter/material.dart';

class OnboardingScreenThree extends StatelessWidget {
  final VoidCallback onStart;
  const OnboardingScreenThree({required this.onStart, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Onboarding Screen Three')),
      floatingActionButton: FloatingActionButton(
        onPressed: onStart,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
