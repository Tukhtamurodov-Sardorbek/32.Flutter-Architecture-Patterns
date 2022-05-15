import 'dart:convert';
import 'package:contacts_mock_api_bloc/models/contact_model.dart';
import 'package:hive/hive.dart';


class HiveService {
  static String DB_NAME = 'database';
  static Box box = Hive.box(DB_NAME);
  static const key = 'contacts';

  static Future<void> storeData (List<Contact> data) async {
    // Object => Map => String
    List<String> stringData = List<String>.from(data.map((e) => jsonEncode(e.toJson())).toList());
    await box.put(key, stringData);
  }

  static List<Contact> loadData(){
    if(box.containsKey(key)){
      // String => Map => Object
      List<String> stringData = box.get(key);
      List<Contact> data = stringData.map((e) => Contact.fromJson(jsonDecode(e))).toList();
      print('String: ${stringData.length} \t Data: ${data.length}');
      return data;
    }
    return [];
  }

  static Future<void> removeData(int id) async{
    if(box.containsKey(key)){
      // String => Map => Object
      List<String> stringData = box.get(key);
      stringData.removeAt(id - 1);
      box.put(key, stringData);
    }
  }

  static Future<void> clearData () async {
    await box.delete(key);
  }
}