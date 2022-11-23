import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:cafe21/cons/app_color.dart';
import 'package:cafe21/controller/admin_dashboard_controller.dart';
import 'package:cafe21/controller/common_function.dart';
import 'package:cafe21/controller/connection_checker.dart';
import 'package:cafe21/model/data.dart';

import 'package:cafe21/controller/dashboard_controller.dart';

class WaiterListPage extends StatefulWidget {
  const WaiterListPage({Key? key}) : super(key: key);

  @override
  State<WaiterListPage> createState() => _WaiterListPageState();
}

class _WaiterListPageState extends State<WaiterListPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      constraints: const BoxConstraints(),
      child: allWaiterData.isEmpty ? const Center(child: Text('No waiter date')) : Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child:  Text('Total waiter: ${allWaiterData.length}'),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: allWaiterData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  isThreeLine: false,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  dense: true,
                  onTap: () {
                    editWaiter(index);
                  },
                  onLongPress: () {
                    deleteWaiter(index);
                  },
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text((index + 1).toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                  title: Text('Name: ${allWaiterData[index]['name']}'),
                  subtitle: Text('Phone: ${allWaiterData[index]['phone']}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '100',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Orders'.toUpperCase(),
                        style: const TextStyle(fontSize: 9),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 4,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //  Waiter Data Manipulation

  editWaiter(index) {
    TextEditingController idController =
    TextEditingController(text: allWaiterData[index]['id']);
    TextEditingController nameController =
    TextEditingController(text: allWaiterData[index]['name']);
    TextEditingController phoneController =
    TextEditingController(text: allWaiterData[index]['phone']);
    TextEditingController nidController =
    TextEditingController(text: allWaiterData[index]['nid']);
    TextEditingController emailController =
    TextEditingController(text: allWaiterData[index]['email']);
    TextEditingController addressController =
    TextEditingController(text: allWaiterData[index]['address']);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: AppColor.drawerListTileColor,
              scrollable: true,
              title: const Text(
                'Add waiter data',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.deepPurple),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      height: 28,
                      child: TextField(
                        controller: idController,
                        style: TextStyle(color: Colors.deepPurple.shade900),
                        decoration: InputDecoration(
                          hintText: 'Waiter ID',
                          prefix: const Text('ID: '),
                          isDense: true,
                          hintStyle: TextStyle(color: Colors.blue.shade300),
                          suffixIcon: InkWell(
                            onTap: () {
                              idController.clear();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 28,
                      child: TextField(
                        controller: nameController,
                        style: TextStyle(color: Colors.deepPurple.shade900),
                        decoration: InputDecoration(
                          hintText: 'Waiter name',
                          prefix: const Text('Name: '),
                          isDense: true,
                          hintStyle: TextStyle(color: Colors.blue.shade300),
                          suffixIcon: InkWell(
                            onTap: () {
                              nameController.clear();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 28,
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.deepPurple.shade900),
                        decoration: InputDecoration(
                          hintText: 'Phone number',
                          prefix: const Text('Phone: '),
                          isDense: true,
                          hintStyle: TextStyle(color: Colors.blue.shade300),
                          suffixIcon: InkWell(
                            onTap: () {
                              phoneController.clear();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 28,
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.deepPurple.shade900),
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          prefix: const Text('Email: '),
                          isDense: true,
                          hintStyle: TextStyle(color: Colors.blue.shade300),
                          suffixIcon: InkWell(
                            onTap: () {
                              emailController.clear();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 28,
                      child: TextField(
                        controller: nidController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.deepPurple.shade900),
                        decoration: InputDecoration(
                          hintText: 'National id number',
                          prefix: const Text('Nid: '),
                          isDense: true,
                          hintStyle: TextStyle(color: Colors.blue.shade300),
                          suffixIcon: InkWell(
                            onTap: () {
                              nidController.clear();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 28,
                      child: TextField(
                        controller: addressController,
                        style: TextStyle(color: Colors.deepPurple.shade900),
                        decoration: InputDecoration(
                          hintText: 'Details Address',
                          isDense: true,
                          prefix: const Text('Address: '),
                          hintStyle: TextStyle(color: Colors.blue.shade300),
                          suffixIcon: InkWell(
                            onTap: () {
                              addressController.clear();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              alignment: Alignment.center,
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                MaterialButton(
                  color: const Color(AppColor.box4),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MaterialButton(
                  color: const Color(AppColor.box5),
                  onPressed: () async {
                    if(idController.text.isEmpty){
                      CommonFunction().showSnackBar('Id can not be empty!', context);
                    }
                    else if(nameController.text.isEmpty){
                      CommonFunction().showSnackBar('Name can not be empty!', context);
                    }
                    else if(phoneController.text.isEmpty){
                      CommonFunction().showSnackBar('Phone can not be empty!', context);
                    }
                    else if(emailController.text.isEmpty){
                      CommonFunction().showSnackBar('Email can not be empty!', context);
                    }
                    else if(nidController.text.isEmpty){
                      CommonFunction().showSnackBar('NID can not be empty!', context);
                    }
                    else if(addressController.text.isEmpty){
                      CommonFunction().showSnackBar('Address can not be empty!', context);
                    }else if(nidController.text.isEmpty){
                      CommonFunction().showSnackBar('NID can not be empty!', context);
                    }
                    else if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
                      CommonFunction().showSnackBar('No internet!\nCheck internet connection', context);
                    }
                    else{
                      Navigator.pop(context);
                      showLoadingDialog('Updating...');
                      bool isSuccessful =
                      await AdminDashboardController().updateWaiterData({
                        'docId' : allWaiterData[index]['docId'],
                        'id': idController.text,
                        'name': nameController.text,
                        'phone': phoneController.text,
                        'email': emailController.text,
                        'nid': nidController.text,
                        'address': addressController.text,
                        'image': '',
                      });
                      if(isSuccessful){
                        await fetchUpdatedData();
                        pop();
                        showSnackbar('Successfully deleted');

                      }
                      else{
                        pop();
                        showSnackbar('Failed to delete');
                      }
                    }
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  deleteWaiter(index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Are you sure!',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text('This item will be deleted.'),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            MaterialButton(
              onPressed: () async {
                if (connectivityResult != ConnectivityResult.mobile &&
                    connectivityResult != ConnectivityResult.wifi) {
                  CommonFunction().showSnackBar(
                      'No internet!\nCheck internet connection', context);
                } else {
                  Navigator.pop(context);
                  bool isSuccessful = await AdminDashboardController()
                      .deleteWaiterData(allWaiterData[index]['docId']);
                  if(isSuccessful){
                    await fetchUpdatedData();
                    showSnackbar('Successfully deleted');
                  }else{
                    showSnackbar('Failed to delete');
                  }
                }
              },
              color: const Color(AppColor.box5),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: const Color(AppColor.box4),
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
  pop(){
    Navigator.pop(context);
  }
  fetchUpdatedData() async {
    allWaiterData.clear();
    await DashboardController().getAllWaiter();
    setState(() {});
  }
  showSnackbar(String msg){
    CommonFunction().showSnackBar(msg, context);
  }
  showLoadingDialog(String title){
    CommonFunction().showLoadingIndicatorWithTitle(context: context, title: title);
  }
}
