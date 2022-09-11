import 'package:cafe21/app_color.dart';
import 'package:cafe21/model/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildListItem extends StatelessWidget {
  const BuildListItem(
      {Key? key, required this.index, required this.invoiceData})
      : super(key: key);
  final int index;
  final InvoiceModel invoiceData;

  @override
  Widget build(BuildContext context) {
    int totalAmount = 0;
    for (var i = 0; i < invoiceData.orders.length; i++) {
      totalAmount = totalAmount +
          (int.parse(invoiceData.orders[i]['price']) *
              int.parse(invoiceData.orders[i]['quantity']));
    }
    // print(totalAmount.toString());
    return Stack(
      children: [
        Container(
          height: 55,
          margin: const EdgeInsets.only(left: 16, bottom: 4, top: 4),
          padding: const EdgeInsets.only(left: 24,),
// color: index % 2 == 0 ? Colors.blue.shade50 : Colors.blue.shade100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(DateFormat.yMMMd()
                        .add_jm()
                        .format(invoiceData.dateTime.toDate())
                        .toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: .5),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text('id: ${invoiceData.invoiceId}',
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '\$$totalAmount',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black87),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 1),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Text('paid'.toUpperCase(), style: const TextStyle(fontSize: 9, color: Colors.white),))
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          child: CircleAvatar(
            child: Text(
              '${index + 1}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

