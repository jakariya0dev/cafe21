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
                'Invoice id:',
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
                'Odered item(s):',
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
                'Total amount:',
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
                'Total discount (5%):',
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
                'Total tax (10%):',
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
                'Total bill:',
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
