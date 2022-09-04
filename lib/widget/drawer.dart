import 'package:cafe21/app_color.dart';
import 'package:cafe21/views/admin_dashboard.dart';
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
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(child: Text('Logo')),
            accountName: Text('Manager'),
            accountEmail: Text('Chef de cuisine'),
          ),
          Expanded(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard(),));

                  },
                  child: const DrawerListTile(
                    icon: Icons.account_balance_wallet_outlined,
                    text: 'Total summery',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard(),));

                  },
                  child: const DrawerListTile(
                    icon: Icons.view_day_outlined,
                    text: 'Daily data',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard(),));

                  },
                  child: const DrawerListTile(
                    icon: Icons.weekend_outlined,
                    text: 'Weekly data',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard(),));

                  },
                  child: const DrawerListTile(
                    icon: Icons.calendar_month,
                    text: 'Monthly data',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard(),));

                  },
                  child: const DrawerListTile(
                    icon: Icons.admin_panel_settings_outlined,
                    text: 'Admin area',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard(),));

                  },
                  child: const DrawerListTile(
                    icon: Icons.logout,
                    text: 'Logout',
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            dense: true,
            leading: const Icon(Icons.devices),
            title: const Text('Developer info'),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(context);
            },
          ),
        ],
      ),
    );

  }

  showAboutDialog(context){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        scrollable: true,
        backgroundColor: Colors.purple.shade500,
        elevation: 24,
        actionsAlignment: MainAxisAlignment.center,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            const SizedBox(height: 16,),
            const Text('Brain Storm 21', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),),
            Text('Your Complete it partner', style: TextStyle(color: Colors.grey.shade300),),
            Text('www.brainstorm21.com', style: TextStyle(color: Colors.grey.shade300),),
            Text('Cell: +8801521466603', style: TextStyle(color: Colors.grey.shade300),),
            const SizedBox(height: 16,),
            const Text('Email:\nquery@brainstorm21.com', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),

          ],

        ),
        actions: [
          MaterialButton(
            shape: const StadiumBorder(),
            onPressed: () => Navigator.pop(context),
            textColor: Colors.white,
            color: const Color(AppColor.box7),
            child: const Text('OK'),
          )
        ],
      );
    },);
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key, required this.icon, required this.text,

  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 4, bottom: 4),
      child: Row(
        children:  [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(width: 16,),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w500),)],
      ),
    );
  }
}
