import 'package:shared_preferences/shared_preferences.dart';
import 'invoice_model.dart';

SharedPreferences? prefs;

List <InvoiceModel> allSellsData = [];
List allFoodsData = [];
List allWaiterData = [];
List allCategoryData = [];
List allAppUserData = [];

/*
cafeDetails = {
  'cafe-name': '',
  'cafe-address': '',
  'cafe-phone': '',
}
*/
Map<String, dynamic> cafeDetailsData = {};
Map<String, dynamic> developerInfo = {
  'info' : 'System Developed By',
  'name' : 'Brain Storm 21',
  'web' : 'www.brainstorm21.com',
  'phone' : '+8801521466603'
};