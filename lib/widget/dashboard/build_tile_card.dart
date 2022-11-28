import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/model/data.dart';
import 'package:flutter/material.dart';

class BuildTitleCard extends StatefulWidget {

  const BuildTitleCard({Key? key, required this.value, required this.width, required this.title}) : super(key: key);

  final double value;
  final double width;
  final String title;

  @override
  State<BuildTitleCard> createState() => _BuildTitleCardState();
}

class _BuildTitleCardState extends State<BuildTitleCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          height: widget.width * 0.4,
          width: widget.width,
          decoration: const BoxDecoration(color: Color(0xff7c79ea)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Sells'),
                      ),
                      Text(
                        '\$${widget.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Text(
                    'Total No. invoice: ${allSellsDataFiltered.length}',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      DashboardController().getDataByDate(context);
                      setState(() {});
                      print('ref btn clc');
                    },
                    icon: const Icon(Icons.calendar_month, color: Colors.white,),
                  ),
                  IconButton(
                    onPressed: () {
                      DashboardController().getDailyData();
                      print('ref btn clc');
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white,),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}