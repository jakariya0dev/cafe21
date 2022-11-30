
import 'package:flutter/material.dart';


List<String> paymentMethodList = [
  'Cash payment',
  'Online Payment',
  'Mobile Banking',
  'Payment Due'
];

List<String> buttonList = ['All', 'Paid', 'Unpaid'];

class Const {

  static const double headerFontSize = 18;
  static const TextStyle subHeadingStyle =
  TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500);
  static const invDetailsListTitle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blueGrey);
  static const invDetailsListPrice = TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.blueGrey);
  static const italicStyleSubHeading = TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic);

  // <--- var for on boarding page ---> START
  static const onBoardingTitle1 = '';
  static const onBoardingTitle2 = '';
  static const onBoardingTitle3 = '';
  static const onBoardingTitle4 = '';

  static const onBoarding1 = '';
  static const onBoarding2 = '';
  static const onBoarding3 = '';
  static const onBoarding4 = '';
  // <--- var for on boarding page ---> END

  static TextStyle waiterEditDialogEditTextStyle= TextStyle(color: Colors.deepPurple.shade900, fontSize: 14);
  static TextStyle errorMsgStyle = const TextStyle(fontSize: 15, color: Colors.red);
}

var dummyImage =
    'https://images.pexels.com/photos/2983101/pexels-photo-2983101.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

