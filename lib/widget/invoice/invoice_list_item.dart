import 'package:cafe21/cons/const.dart';
import 'package:cafe21/model/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildInvoiceListItem extends StatelessWidget {
  const BuildInvoiceListItem(
      {Key? key,
        required this.index,
        required this.invoiceData,
        required this.length})
      : super(key: key);
  final int index, length;
  final InvoiceModel invoiceData;

  @override
  Widget build(BuildContext context) {

    bool isPaid;
    double netBill = double.parse(invoiceData.netBill);

    if (invoiceData.paymentMethod == paymentMethodList[3]) {
      isPaid = false;
    }
    else {
      isPaid = true;
    }

    return Stack(
      children: [
        Container(
          height: 65,
          margin: const EdgeInsets.only(left: 16, bottom: 4, top: 4),
          padding: const EdgeInsets.only(
              left: 24
          ),
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
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'id: ${invoiceData.invoiceId}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    const SizedBox(
                        height: 2
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat.yMMMd()
                              .add_jm()
                              .format(invoiceData.dateTime.toDate())
                              .toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              letterSpacing: .5),
                        ),
                        const SizedBox(width: 4),
                        Container(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 2, bottom: 1),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(16)),
                            child: Text(
                              isPaid ? 'PAID' : 'UNPAID',
                              style: const TextStyle(
                                  fontSize: 8, color: Colors.white),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: RichText(
                    text: TextSpan(
                        text: '\$',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey.shade400),
                        children: [
                          TextSpan(
                            text: netBill.toStringAsFixed(1),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black87),
                          )
                        ]),
                  ),
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
              '${length - index}',
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