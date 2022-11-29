import 'package:cafe21/cons/enums.dart';
import 'package:cafe21/controller/auth_controller.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/dashboard_controller.dart';
import 'package:cafe21/model/data.dart';
import 'package:cafe21/views/admin/admin_dashboard.dart';
import 'package:cafe21/views/on_boarding_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key, required this.updateSate}) : super(key: key);

  final VoidCallback updateSate;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userRoleData.toString()[0].toUpperCase()+userRoleData.toString().substring(1), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
            accountEmail: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userEmailData ?? ''),
                const SizedBox(height: 4),
                Text(cafeDetailsData['cafe-name'] ??'', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    await DashboardController().getAllTotalData();
                    updateSate();
                  },
                  child: const DrawerListTile(
                    icon: Icons.account_balance_wallet_outlined,
                    text: 'Total summery',
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    await DashboardController().getDailyData();
                    updateSate();
                  },
                  child: const DrawerListTile(
                    icon: Icons.view_day_outlined,
                    text: 'Today\'s Data',
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    await DashboardController().getWeeklyData();
                    updateSate();
                  },
                  child: const DrawerListTile(
                    icon: Icons.weekend_outlined,
                    text: 'Weekly data',
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    await DashboardController().getMonthlyData();
                    updateSate();
                  },
                  child: const DrawerListTile(
                    icon: Icons.calendar_month,
                    text: 'Monthly data',
                  ),
                ),
                InkWell(
                  onTap: () {
                    print(userRoleData);
                    print(UserRole.admin);

                    if(userRoleData == UserRole.admin.name){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard(index: 0),));
                    }
                    else{
                      Navigator.pop(context);
                      CommonFunction().showWarningDialog('Only admin access.', context);
                    }

                  },
                  child: const DrawerListTile(
                    icon: Icons.admin_panel_settings_outlined,
                    text: 'Admin area',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OnBoardingPage()));
                  },
                  child: const DrawerListTile(
                    icon: Icons.admin_panel_settings_outlined,
                    text: 'App Helper',
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await AuthController().userLogOut(context);
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
            title: const Center(child: Text('Developer info')),
            onTap: () {
              Navigator.pop(context);
              CommonFunction().showAboutDialog(context);
            },
          ),
        ],
      ),
    );
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
      padding: const EdgeInsets.only(left: 24, top: 8, bottom: 8),
      child: Row(
        children:  [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(width: 20,),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),)],
      ),
    );
  }
}