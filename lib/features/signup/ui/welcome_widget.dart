import 'package:flutter/material.dart';
import 'package:mygymbuddy/texts/texts.dart';
class LowerWelcome extends StatelessWidget {
  const LowerWelcome({
    super.key,
    required this.textTheme,
    required this.subTitle
  });

  final TextTheme textTheme;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(
          welcomeText,
          style: textTheme.displaySmall,
        ),
        SizedBox(
          height: 1,
        ),
        Text(
          subTitle,
          style: textTheme.labelLarge,
        )
      ],
    ));
  }
}

class UpperWelcome extends StatelessWidget {
  const UpperWelcome({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appName,
              style: textTheme.headlineSmall,
            ),
            SizedBox(height: 1), // Add some spacing between the texts
            Text(
              idealBuddy,
              style: textTheme.labelMedium,
            ),
            SizedBox(
              height: 10,
            ),
            Image(
              image: AssetImage(stretchingImage),
              height: 150,
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}