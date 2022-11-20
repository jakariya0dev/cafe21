import 'package:flutter/material.dart';

class AppUser extends StatefulWidget {
  const AppUser({Key? key}) : super(key: key);

  @override
  State<AppUser> createState() => _AppUserState();
}

class _AppUserState extends State<AppUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child:  Text('Total app user 2'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Column(
                      children: const [
                        CircleAvatar(child: Icon(Icons.person)),
                        SizedBox(height: 2),
                        Text('Manager', style: TextStyle(fontSize: 11),),
                      ],
                    ),
                    title: const Text('Email: abc@mail.com'),
                    subtitle: const Text('Password: 234567890'),
                    trailing: InkWell(child: Icon(Icons.edit),),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
