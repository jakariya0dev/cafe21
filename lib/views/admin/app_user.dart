import 'package:cafe21/controller/admin_dashboard_controller.dart';
import 'package:cafe21/controller/app_user_controller.dart';
import 'package:cafe21/views/admin/update_app_user.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/connection_checker.dart';
import 'package:cafe21/model/data.dart';

class AppUser extends StatefulWidget {
  const AppUser({Key? key}) : super(key: key);

  @override
  State<AppUser> createState() => _AppUserState();
}

class _AppUserState extends State<AppUser> {

  @override
  initState() {
    init();
    super.initState();
  }

  init() async {
    print(allAppUserData);
    ConnectionChecker().checkInternetConnection(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: allAppUserData.isEmpty ? const Center(child: Text('No user found'),): Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child:  Text('Total app user ${allAppUserData.length}'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allAppUserData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Column(
                      children: [
                        const CircleAvatar(child: Icon(Icons.person)),
                        const SizedBox(height: 2),
                        Text(allAppUserData[index]['user-role'], style: const TextStyle(fontSize: 11),),
                      ],
                    ),
                    title: Text(allAppUserData[index]['user-email']),
                    subtitle: Text('Password: ${allAppUserData[index]['user-password']}'),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if(value=='delete'){
                          deleteUser(index);
                        }else{
                          updateUser(index);
                        }
                      },
                      itemBuilder: (context) {
                      return [
                        const PopupMenuItem(value: 'delete', child: Text('Delete user')),
                        const PopupMenuItem(value: 'update', child: Text('Update user'))
                      ];
                    },

                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  deleteUser(int index) async {
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      CommonFunction()
          .showSnackBar('No internet!\nCheck internet connection', context);
    } else {

      CommonFunction().showLoadingIndicatorWithTitle(title: 'Deleting user', context: context);
      bool isSuccessful = await AppUserController().deleteUser(index);

      if(isSuccessful){
        allAppUserData.clear();
        await AdminDashboardController().getAppUserData();
        Navigator.pop(context);
        CommonFunction().showSnackBar('Successfully deleted', context);
        setState(() {

        });
      }else{
        CommonFunction().showSnackBar('Failed to deleted', context);
      }
    }

  }

  updateUser(int index) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UpdateAppUser(user: allAppUserData[index])));
  }

}
