import 'package:flutter/material.dart';

class DiscountContainer extends StatelessWidget {

  final String discount, type;
  const DiscountContainer({Key? key, required this.discount, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      if (discount=='') {
        return const SizedBox();
      } else {
        return Container(
          padding: const EdgeInsets.only(top: 4, bottom: 2, left: 8, right: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50)),
          child: Text(
            'DISC $discount$type',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade800),
          ),
        );
      }

  }
}
