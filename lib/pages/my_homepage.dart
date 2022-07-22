import 'package:cafe21/pages/invoice.dart';
import 'package:flutter/material.dart';

import '../widget/drawer.dart';
import '../widget/list_item.dart';
import '../widget/title_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Chef de cuisine'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            const BuildTitleCard(),
            Expanded(
                child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const BuildListItem();
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade500,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Invoice(),
              ));
        },
      ),
    );
  }
}
