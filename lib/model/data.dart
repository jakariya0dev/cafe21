import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'invoice_model.dart';

SharedPreferences? prefs;

List <InvoiceModel> allSellsData = [];
List allFoodsData = [];
List allWaiterData = [];
List allCategoryData = [];
List allAppUserData = [];
Map<String, dynamic> cafeDetailsData = {};