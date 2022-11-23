import 'package:flutter/material.dart';

import '../cons/const.dart';

class InvoiceItem extends StatelessWidget {
  const InvoiceItem({
    Key? key,
    required this.title,
    required this.data,
    required this.onClick,
  }) : super(key: key);

  final title, data, onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Const.subHeadingStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700),
                  ),
                ],
              ),
              IconButton(
                  onPressed: onClick,
                  icon: const Icon(
                    Icons.add,
                    size: 16,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}