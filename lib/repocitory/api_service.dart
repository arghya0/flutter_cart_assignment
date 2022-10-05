import 'dart:convert';

import 'package:flutter_assignment/model/menu_m.dart';
import 'package:flutter_assignment/model/menu_model.dart';
import 'package:flutter_assignment/repocitory/data.dart';

class ApiService {

  Data _data_json = Data();

  //List<MenuM> menuModel;

  Map<String, List<MenuM>> fetchMenus()  {

    Map<String, List<MenuM>> menu_model =  menuMFromJson(json.encode(_data_json.menu_data_json));


    List data = [];

    for(int i=0; i<_data_json.menu_data_json.length; i++){
      Map<String, dynamic> parsed = Map();
      parsed = {'category': _data_json.menu_data_json.keys.elementAt(i), 'res':_data_json.menu_data_json.values.elementAt(i)};

      data.add(parsed);

    }

    //print('Data -> ${jsonEncode(data)}');

    return menu_model;
  }

  List<MenuModel> fetchMenus2() {

    var resp = _data_json.menu_data_json;

    List data = [];

    for(int i=0; i<resp.length; i++){
      Map<String, dynamic> parsed = Map();
      parsed = {'category': resp.keys.elementAt(i), 'res':resp.values.elementAt(i)};

      data.add(parsed);
    }

    List<MenuModel> menu_mod = menuModelFromJson(jsonEncode(data));

    return menu_mod;
  }

}