
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class SaveData{

  static addProdtoSharedPref(List data) async {

    var any = await SharedPreferences.getInstance();

    any.setString("cartData", jsonEncode(data));
  }

  static getCatrData() async {
    final prefs = await SharedPreferences.getInstance();
    var obtainedData = prefs.getString("cartData");
    //final parsed = json.decode(obtainedData);

    //print('this method running ${obtainedData}');

    return obtainedData;
  }

  static getTotalAmount() async {
    final prefs = await SharedPreferences.getInstance();
    var obtainedData = prefs.getString("cartData");
    final parsed = json.decode(obtainedData);

    var rate_quan = [];
    for(int i=0; i<parsed.length; i++) {

      int tot = parsed[i]['rate'] * parsed[i]['quant'];

      rate_quan.add(tot);

    }
    var sum = 0;

    if (rate_quan != null){
      for(int i=0; i<rate_quan.length; i++) {
        sum += rate_quan[i];
      }
    } else {
      sum = 0;
    }

    print('chk_leng- ${sum}');

    return sum;
  }

  static getProductName() async {
    final prefs = await SharedPreferences.getInstance();
    var obtainedData = prefs.getString("cartData");
    final parsed = json.decode(obtainedData);

    var product_arr = [];
    for(int i=0; i<parsed.length; i++) {
      var name = parsed[i]['prod'];

      product_arr.add(name);
      //return name;
    }

    return product_arr;
  }

  static clearPreff() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}