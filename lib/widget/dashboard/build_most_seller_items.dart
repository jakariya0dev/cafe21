import 'package:flutter/material.dart';

class BuildMostSellerList extends StatelessWidget {
  const BuildMostSellerList({
    Key? key, required this.items, required this.height, required this.width, required this.waiterList, required this.title, required this.isLoading,
  }) : super(key: key);

  final Map items;
  final List waiterList;
  final double height, width;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Color(0xff40407a)),
      child: isLoading ? const Center(child: SizedBox(height: 16, width: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.5,))) : items.isEmpty ? const Text('No data available') : Column(
        children:  [
          Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {

                List waiter = waiterList.where((element) => element['name'] == items.keys.elementAt(index)).toList();

                return Container(
                  height: 32,
                  padding: const EdgeInsets.all(8),
                  color: index%2==0? Colors.blue.shade300 : Colors.blue.shade200,
                  child: Row(
                    children: [
                      Text('${index+1}. '),
                      Expanded(child: Text(waiter.isNotEmpty ? waiter[0]['name'] : 'Anonymous')),
                      Text(items.values.elementAt(index).toString())
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