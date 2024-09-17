import 'package:flutter/material.dart';

class OnboardingScreenOne extends StatelessWidget {
  final VoidCallback onNext;

  const OnboardingScreenOne({required this.onNext, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Onboarding Screen One')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onNext();
          });
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

