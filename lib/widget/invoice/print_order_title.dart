import 'package:flutter/material.dart';

class BuildOrderTitle extends StatelessWidget {
  const BuildOrderTitle(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}