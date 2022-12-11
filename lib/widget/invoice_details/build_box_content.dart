import 'package:flutter/material.dart';

class BuildBoxContent extends StatelessWidget {
  const BuildBoxContent(
      {Key? key,
        required this.title,
        required this.value,
        required this.type,
        required this.color})
      : super(key: key);

  final String title, value, type;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 85,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color(color), borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              text: TextSpan(
                  text: value,
                  style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                  children: [
                    TextSpan(
                        text: type,
                        style: const TextStyle(fontSize: 14, color: Colors.white70))
                  ])),
          const SizedBox(
            height: 5,
          ),
          Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 11, color: Colors.white),
          ),
        ],
      ),
    );
  }
}