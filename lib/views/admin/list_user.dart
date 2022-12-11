import 'package:cafe21/controller/auth_controller.dart';
import 'package:cafe21/views/admin/update_app_user.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/connection_checker.dart';
import 'package:cafe21/model/data.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  @override
  initState() {
    _init();
    super.initState();
  }

  _init() async {
    await ConnectionChecker().checkInternetConnection(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: allAppUserData.isEmpty ? const Center(child: Text('No user found')): Column(
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
                        const CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.person, color: Colors.white,),),
                        const SizedBox(height: 2),
                        Text(allAppUserData[index]['user-role'], style: const TextStyle(fontSize: 11),),
                      ],
                    ),
                    title: Text(allAppUserData[index]['user-email']),
                    subtitle: Text('Password: ${allAppUserData[index]['user-password']}'),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if(value=='delete'){
                          _deleteUser(index);
                        }else{
                          _updateUser(index);
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

  _deleteUser(int index) async {
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      CommonFunction.showGetXSnackBar('No internet!','Check internet connection');
    } else {

      CommonFunction().showLoadingIndicatorWithTitle(title: 'Deleting user', context: context);
      bool isSuccessful = await AuthController().deleteUser(index);

      if(isSuccessful){
        allAppUserData.clear();
        await AuthController().getAppUserData();
        _pop();
        CommonFunction.showGetXSnackBar('Message!', 'Successfully deleted');
        setState(() {

        });
      }else{
        CommonFunction.showGetXSnackBar('Error!', 'Failed to deleted');
      }
    }

  }

  _updateUser(int index) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UpdateAppUser(user: allAppUserData[index])));
  }

  _pop() {
    Navigator.pop(context);
  }

}
