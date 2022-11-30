import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/model/data.dart';
import 'package:flutter/material.dart';

class BuildTitleCard extends StatelessWidget {

  const BuildTitleCard({Key? key, required this.value, required this.width, required this.title, required this.updateSate}) : super(key: key);

  final double value;
  final double width;
  final String title;
  final VoidCallback updateSate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          height: width * 0.4,
          width: width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
               Color(0xff0f79ff),
               Color(0xff7c79ea),

              ]),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 20, fontFamily: 'Lato', fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Total'),
                      ),
                      Text(
                        '\$${value.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600, letterSpacing: 1),
                      )
                    ],
                  ),
                  Text(
                    'Total invoice No. 0${allSellsDataFiltered.length}',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await DashboardController().getDataByDate(context);
                      updateSate();
                    },
                    icon: const Icon(Icons.calendar_month, color: Colors.white,),
                  ),
                  IconButton(
                    onPressed: () async {
                      await DashboardController().getDailyData();
                      updateSate();
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