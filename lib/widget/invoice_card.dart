import 'package:flutter/material.dart';

class InvoiceCard extends StatefulWidget {
  const InvoiceCard({Key? key}) : super(key: key);

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Invoice Summery',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Odered Item(s):',
                textAlign: TextAlign.center,
              ),
              Text(
                '11',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Divider(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total Amount:',
                textAlign: TextAlign.center,
              ),
              Text(
                '\$ 1100',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Divider(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total Discount:',
                textAlign: TextAlign.center,
              ),
              Text(
                '\$ 100',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Divider(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total Tax:',
                textAlign: TextAlign.center,
              ),
              Text(
                '\$ 110',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Divider(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total Bill:',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '\$ 1000',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
