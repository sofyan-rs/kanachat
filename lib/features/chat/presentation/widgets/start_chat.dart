import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class StartChat extends StatelessWidget {
  const StartChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              SolarIconsOutline.chatRoundDots,
              size: 70,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 10),
            Text(
              'Start Chat',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            Text.rich(
              TextSpan(
                text: 'with ',
                style: TextStyle(fontSize: 16),
                children: [
                  TextSpan(
                    text: 'KanaAI',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
