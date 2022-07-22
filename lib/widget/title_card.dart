import 'package:flutter/material.dart';

class BuildTitleCard extends StatelessWidget {
  const BuildTitleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Todays Summery',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total Bill:',
                textAlign: TextAlign.center,
              ),
              Text(
                '\$ 110',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total Amount:',
                textAlign: TextAlign.center,
              ),
              Text(
                '\$ 110',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}