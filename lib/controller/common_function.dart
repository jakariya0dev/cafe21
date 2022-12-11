import 'package:cafe21/cons/app_color.dart';
import 'package:cafe21/model/data.dart';
import 'package:cafe21/widget/about_dialog_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonFunction {

  // static bool isCategoryDatabaseCreated = false, isWaiterDatabaseCreated = false;
  // static bool isFoodDatabaseCreated = false, isInvoiceDatabaseCreated = false;

  showWarningDialog(msg, context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning!'),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  showLoadingIndicatorWithTitle({required context, required title, message}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: ListTile(
              leading: const CircularProgressIndicator(),
              title: Text(title),
              subtitle: Text(message ?? 'Please wait.'),
            ),
          );
        });
  }

  static showGetXSnackBar(String title, String message){
    Get.snackbar(title, message, );
  }

  // showSnackBar(msg, context) {
  //   SnackBar snackBar = SnackBar(
  //     content: Text(msg),
  //     action: SnackBarAction(
  //         label: 'ok',
  //         onPressed: () {
  //           ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //         }),
  //   );
  //   scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  // }

  String generateInvoiceId() {
    String id, year, month, day, hour, minute, second;
    DateTime date = DateTime.now();
    year = date.year.toString();
    int pMonth = date.month;
    int pDay = date.day;
    int pHour = date.hour;
    int pMinute = date.minute;
    int pSecond = date.second;

    if (pMonth < 10) {
      month = pMonth.toString().padLeft(2, '0');
    } else {
      month = pMonth.toString();
    }

    if (pDay < 10) {
      day = pDay.toString().padLeft(2, '0');
    } else {
      day = pDay.toString();
    }

    if (pHour < 10) {
      hour = pHour.toString().padLeft(2, '0');
    } else {
      hour = pHour.toString();
    }

    if (pMinute < 10) {
      minute = pMinute.toString().padLeft(2, '0');
    } else {
      minute = pMinute.toString();
    }

    if (pSecond < 10) {
      second = pSecond.toString().padLeft(2, '0');
    } else {
      second = pSecond.toString();
    }

    id = year + month + day + hour + minute + second;
    return id;
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
            const Text('System Developed By', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),),
            Text(developerInfo['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22, fontFamily: 'Michroma'),),
            const SizedBox(height: 20),
            BuildListTileForAboutDialog(icon: Icons.webhook, title: developerInfo['web']),
            const SizedBox(height: 10),
            BuildListTileForAboutDialog(icon: Icons.email_outlined, title: developerInfo['mail']),
            const SizedBox(height: 10),
            BuildListTileForAboutDialog(icon: Icons.phone, title: developerInfo['cell']+" (whatsApp)"),
          ],

        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            // textColor: Colors.white,/
            color: const Color(AppColor.box7),
            icon: const Icon(Icons.close, color: Colors.white,),
          )
        ],
      );
    },);

  }

  static bool emailValidator(String email){
    bool isEmailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return isEmailValid;
  }


}
