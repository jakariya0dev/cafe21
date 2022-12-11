import 'package:flutter/material.dart';

class BuildInvoiceRow extends StatelessWidget {
  const BuildInvoiceRow(this.title, this.value, {Key? key}) : super(key: key);

  final String title, value;

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
            Text(
              value,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}