import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiki_flutter/utils/color.dart';

class OnboardingScreenTwo extends StatelessWidget {
  final VoidCallback onNext;

  const OnboardingScreenTwo({required this.onNext, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: Container(
        color: white,
        child: Center(
          child: isPortrait ? _buildVerticalLayout(context) : _buildHorizontalLayout(context),
        ),
      ),
    );
  }

  Widget _buildVerticalLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 74),
        SvgPicture.asset(
          'assets/images/three_points_red.svg',
          width: 42,
          height: 12,
        ),
        const SizedBox(height: 106),
        SvgPicture.asset(
          'assets/images/speech_bubble.svg',
          width: 174.5,
          height: 80.36,
        ),
        const SizedBox(height: 32),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
          child: Text(
            'Converse com sobre qualquer tema e com vocabulário adaptado ao seu nível de compreensão',
            style: TextStyle(
              color: secundary,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: secundary,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Avançar',
            style: TextStyle(color: white),
          ),
        ),
        const SizedBox(height: 120),
        SvgPicture.asset(
          'assets/images/hiki_logo_without_text.svg',
          width: 68,
          height: 25,
        ),
      ],
    );
  }

  Widget _buildHorizontalLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/three_points.svg',
                  width: 42,
                  height: 12,
                ),
                const SizedBox(height: 24),
                SvgPicture.asset(
                  'assets/images/hiki_logo.svg',
                  width: 174.5,
                  height: 80.36,
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            width: 1,
            color: secundary,
            margin: const EdgeInsets.symmetric(horizontal: 32),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Converse com sobre qualquer tema e com vocabulário adaptado ao seu nível de compreensão',
                    style: TextStyle(
                      color: secundary,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secundary,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Avançar',
                    style: TextStyle(color: white),
                  ),
                ),
                const SizedBox(height: 24),
                SvgPicture.asset(
                  'assets/images/hiki_logo_without_text.svg',
                  width: 68,
                  height: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
