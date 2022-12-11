import 'package:flutter/material.dart';

import 'build_list_tile.dart';

class BuildOrderItemList extends StatelessWidget {
  const BuildOrderItemList({
    Key? key,
    required this.orders,
  }) : super(key: key);

  final List orders;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return BuildListTile(
            index: index,
            orders: orders,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: orders.length,
      ),
    );
  }
}