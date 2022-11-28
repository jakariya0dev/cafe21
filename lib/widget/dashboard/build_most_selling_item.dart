import 'package:cafe21/model/data.dart';
import 'package:flutter/material.dart';

class BuildMostSellingItem extends StatelessWidget {
  const BuildMostSellingItem({
    Key? key, required this.mostSellingItems, required this.height, required this.width, required this.title, required this.isLoading,
  }) : super(key: key);

  final Map mostSellingItems;
  final double height, width;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Color(0xff40407a)),
      child: isLoading ? const Center(child: SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.5,))) : mostSellingItems.isEmpty ? const Text('No data available') : Column(
        children: [
          Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
              height: 16
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: mostSellingItems.length,
              itemBuilder: (context, index) {

                List foodName = allFoodsData.where((element) => element['id'] == mostSellingItems.keys.elementAt(index)).toList();

                return Container(
                  height: 32,
                  padding: const EdgeInsets.all(8),
                  color: index%2==0? Colors.blue.shade300 : Colors.blue.shade200,
                  child: Row(
                    children: [
                      Expanded(child: foodName.isNotEmpty ? Text("${index+1}. ${foodName[0]['name']}") : Text("${index+1}. Anonymous")),
                      Text(mostSellingItems.values.elementAt(index).toString())
                    ],
                  ),
                );
              },),
          )
        ],
      ),
    );
  }
}