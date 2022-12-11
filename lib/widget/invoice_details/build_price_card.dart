import 'package:flutter/material.dart';

class BuildPriceCard extends StatelessWidget {
  const BuildPriceCard({
    Key? key,
    required this.totalAmount,
    required this.totalAmountAfterDiscount,
    required this.netAmount,
  }) : super(key: key);

  final String totalAmount, totalAmountAfterDiscount, netAmount;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 100,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
              )
            ]),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount'.toUpperCase(),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                          text: '\$',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade400),
                          children: [
                            TextSpan(
                              text: totalAmount,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700),
                            )
                          ]),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'After discount'.toUpperCase(),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                          text: '\$',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade400),
                          children: [
                            TextSpan(
                              text: totalAmountAfterDiscount,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.grey.shade300,
              thickness: 1,
              endIndent: 10,
              indent: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Net bill'.toUpperCase(),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: RichText(
                      text: TextSpan(
                        text: '\$',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade400),
                        children: [
                          TextSpan(
                            text: netAmount,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '\$${(double.parse(netAmount) - double.parse(totalAmountAfterDiscount)).toStringAsFixed(1)} Service tax added',
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}