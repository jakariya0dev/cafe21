import 'package:flutter/material.dart';

class BulidTitleText extends StatelessWidget {
  const BulidTitleText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
