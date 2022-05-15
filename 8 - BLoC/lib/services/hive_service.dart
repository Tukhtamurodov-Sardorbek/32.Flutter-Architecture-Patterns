import 'dart:convert';

import 'package:bloc_pattern/models/post_model.dart';
import 'package:hive/hive.dart';


class HiveService {
  static String DB_NAME = 'database';
  static Box box = Hive.box(DB_NAME);

  static Future<void> storeData (List<Post> data) async {
    // Object => Map => String
    List<String> stringData = List<String>.from(data.map((e) => jsonEncode(e.toJson())).toList());
    await box.put('data', stringData);
  }

  static List<Post> loadData(){
    if(box.containsKey('data')){
      // String => Map => Object
      List<String> stringData = box.get('data');
      List<Post> data = stringData.map((e) => Post.fromJson(jsonDecode(e))).toList();
      print('String: ${stringData.length} \t Data: ${data.length}');
      return data;
    }
    return [];
  }

  static Future<void> removeData(int index) async{
    if(box.containsKey('data')){
      // String => Map => Object
      List<String> stringData = box.get('data');
      stringData.removeAt(index + 1);
      box.put('data', stringData);
    }
  }

  static Future<void> clearData () async {
    await box.delete('data');
  }
}