import 'package:flutter/material.dart';

class BuildListItem extends StatelessWidget {
  const BuildListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: Colors.amber.shade200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'id#1234',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: .5),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '12:00 pm 12-12-2022',
                style: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black54),
              ),
            ],
          ),
          const Text(
            '\$120',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
