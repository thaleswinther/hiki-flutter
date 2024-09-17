import 'package:flutter/material.dart';

class OnboardingScreenTwo extends StatelessWidget {
  final VoidCallback onNext;

  const OnboardingScreenTwo({required this.onNext, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Onboarding Screen Two')),
      floatingActionButton: FloatingActionButton(
        onPressed: onNext,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
