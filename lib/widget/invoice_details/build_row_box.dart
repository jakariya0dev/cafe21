import 'package:cafe21/widget/invoice_details/build_box_content.dart';
import 'package:flutter/material.dart';

class BuildBoxRow extends StatelessWidget {
  const BuildBoxRow({
    Key? key,
    required this.discount,
    required this.tax,
    required this.table,
    required this.discountType,
  }) : super(key: key);

  final String discount, discountType, tax, table;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BuildBoxContent(
            title: 'discount',
            value: discount,
            type: discountType,
            color: 0xfffbb35f),
        BuildBoxContent(
            title: 'service Tax', value: tax, type: '%', color: 0xff09af80),
        BuildBoxContent(
            title: 'Table no', value: table, type: '', color: 0xff656565),
      ],
    );
  }
}