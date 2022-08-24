import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildListItem extends StatelessWidget {
  const BuildListItem({
    Key? key,
    required this.index,
    required this.invoiceData
  }) : super(key: key);
  final int index;
  final invoiceData;

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2.5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: index % 2 == 0 ? Colors.white : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: index % 2 == 0
                  ? Colors.amber.shade100
                  : Colors.amber.shade200,
              child: Text(
                '${index + 1}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black87),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    'id: ${invoiceData.invoiceId}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: .5),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  Row(
                    children: [
                      const Icon(Icons.timer_sharp, color: Colors.grey, size: 16,),
                      const SizedBox(width: 5,),
                      Text(
                        DateFormat.yMMMd().add_jm().format(invoiceData.dateTime.toDate()).toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Text(
              '\$999',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
