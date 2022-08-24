import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(child: Text('Logo')),
            accountName: const Text('Manager'),
            accountEmail: const Text('Chef de cuisine'),
            onDetailsPressed: () {},
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.restaurant_sharp),
                  title: const Text('Toady\'s summery'),
                  onTap: () {},
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.restaurant_sharp),
                  title: const Text('Last 7 day\'s summery'),
                  onTap: () {},
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.restaurant_sharp),
                  title: const Text('Last 30 day\'s summery'),
                  onTap: () {},
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.restaurant_sharp),
                  title: const Text('Total summery'),
                  onTap: () {},
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.restaurant_sharp),
                  title: const Text('Top selling item'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.my_library_add),
            title: const Text('Add food'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
