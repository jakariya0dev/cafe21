import 'package:cafe21/cons/const.dart';
import 'package:cafe21/widget/discount_container.dart';
import 'package:flutter/material.dart';

class BuildListTile extends StatelessWidget {
  const BuildListTile({
    Key? key,
    required this.index,
    required this.orders,
  }) : super(key: key);

  final int index;
  final List orders;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.09),
          border: const Border(left: BorderSide(color: Colors.blue, width: 5))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                orders[index]["price"].toString(),
                style: Const.invDetailsListTitle,
              ),
              const Icon(
                Icons.close,
                color: Colors.grey,
                size: 16,
              ),
              Text(
                orders[index]["quantity"].toString(),
                style: Const.invDetailsListTitle,
              ),
              const SizedBox(width: 5),
              DiscountContainer(
                discount: orders[index]["discount"],
                type: orders[index]["discountType"],
              ),
              const Expanded(child: SizedBox()),
              RichText(
                  text: TextSpan(
                      text: '\$',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.blueGrey.shade200),
                      children: [
                        TextSpan(
                          text: orders[index]['itemTotal'],
                          style: Const.invDetailsListPrice,
                        )
                      ]))
            ],
          ),
          Text(
            '${index + 1}. ${orders[index]["name"]}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          )
        ],
      ),
    );
  }
}