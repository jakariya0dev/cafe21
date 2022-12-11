import 'package:shared_preferences/shared_preferences.dart';
import 'invoice_model.dart';

SharedPreferences? prefs;
String? userRoleData, userEmailData;


List <InvoiceModel> allSellsData = [];
List allFoodsData = [];

/*

allWaiterData = {
          'docId' : item.id,
          'name' : item['name'],
          'phone' : item['phone'],
          'email' : item['email'],
          'nid' : item['nid'],
          'address' : item['address'],
          'image' : item['image']
        }
* */
List allWaiterData = [];
List allCategoryData = [];
List allAppUserData = [];
List allSellsDataFiltered = [];



/*
cafeDetails = {
  'cafe-name': '',
  'cafe-address': '',
  'cafe-phone': '',
}
*/

Map<String, dynamic> cafeDetailsData = {};

Map<String, dynamic> developerInfo = {
  'name' : 'Brain Storm 21',
  'mail' : 'query@brainstorm21.com',
  'web' : 'www.brainstorm21.com',
  'cell' : '+8801521466603'
};