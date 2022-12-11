import 'package:cafe21/cons/const.dart';
import 'package:cafe21/model/data.dart';
import 'package:flutter/material.dart';
import 'build_price_card.dart';

class BuildNameContainer extends StatelessWidget {
  const BuildNameContainer({
    Key? key,
    required this.id,
    required this.name,
    required this.phone,
    required this.paymentMethod,
    required this.date,
    required this.totalAmount,
    required this.totalAmountAfterDiscount,
    required this.netAmount,
    required this.address,
    required this.waiterId,
  }) : super(key: key);

  final String id,
      name,
      phone,
      paymentMethod,
      date,
      address,
      waiterId;
  final String totalAmount, totalAmountAfterDiscount, netAmount;

  @override
  Widget build(BuildContext context) {

    List waiter = allWaiterData.where((e) => e['docId'] == waiterId).toList();

    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          Container(
            height: 180,
            width: double.maxFinite,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.shade800,
                      Colors.blue.shade500,
                    ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            radius: 10,
                            child: Text(
                              'id',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(id,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      date,
                      style: Const.italicStyleSubHeading,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        paymentMethod,
                        style: Const.italicStyleSubHeading,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                    height: 3
                ),
                Row(
                  children: [
                    const Text(
                      'Cell: ',
                      style: Const.italicStyleSubHeading,
                    ),
                    Text(
                      phone,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                        width: 8
                    ),
                    const Text(
                      'Served by',
                      style: Const.italicStyleSubHeading,
                    ),
                    const SizedBox(
                        width: 4
                    ),
                    Text(
                      waiter.isEmpty ? 'Anonymous' : waiter[0]['name'],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          BuildPriceCard(
            totalAmount: totalAmount,
            totalAmountAfterDiscount: totalAmountAfterDiscount,
            netAmount: netAmount,
          )
        ],
      ),
    );
  }
}