import 'package:flutter/material.dart';

class BuildListTileForAboutDialog extends StatelessWidget {
  const BuildListTileForAboutDialog({Key? key, required this.icon, required this.title}) : super(key: key);

  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            child: Icon(icon, size: 16,),
          ),
          const SizedBox(width: 16),
          Text(title, style: const TextStyle(fontSize: 12))
        ],
      ),);

  }
}