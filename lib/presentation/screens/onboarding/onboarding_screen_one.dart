import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiki_flutter/utils/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreenOne extends StatelessWidget {
  final VoidCallback onNext;

  const OnboardingScreenOne({required this.onNext, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        color: white,
        child: Center(
          child: isPortrait
              ? _buildVerticalLayout(context, localizations)
              : _buildHorizontalLayout(context, localizations),
        ),
      ),
    );
  }

  Widget _buildVerticalLayout(BuildContext context, AppLocalizations localizations) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 74),
          SvgPicture.asset(
            'assets/images/three_points.svg',
            width: 42,
            height: 12,
          ),
          const SizedBox(height: 106),
          SvgPicture.asset(
            'assets/images/hiki_logo.svg',
            width: 174.5,
            height: 80.36,
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
            child: Text(
              localizations.welcome_message,
              style: const TextStyle(
                color: black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              localizations.next,
              style: const TextStyle(color: white),
            ),
          ),
          const SizedBox(height: 120),
          SvgPicture.asset(
            'assets/images/hiki_logo_without_text.svg',
            width: 68,
            height: 25,
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalLayout(BuildContext context, AppLocalizations localizations) {
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
            color: black,
            margin: const EdgeInsets.symmetric(horizontal: 32),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    localizations.welcome_message,
                    style: const TextStyle(
                      color: black,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: black,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    localizations.next,
                    style: const TextStyle(color: white),
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
