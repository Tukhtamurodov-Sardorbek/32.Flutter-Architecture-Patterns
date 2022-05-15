import 'dart:convert';
import 'package:contacts_mock_api_bloc/models/contact_model.dart';
import 'package:contacts_mock_api_bloc/services/logger_service.dart';
import 'package:http/http.dart';

class Network {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = '62800b531020d8520579612e.mockapi.io';
  static String SERVER_PRODUCTION = '62800b531020d8520579612e.mockapi.io';

  static Map<String, String> getHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    return headers;
  }

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await get(uri, headers: getHeaders());
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response =
    await post(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> MULTIPART(String api, String filePath, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api);
    var request = MultipartRequest('POST', uri);

    request.headers.addAll(getHeaders());
    request.fields.addAll(params);
    request.files.add(await MultipartFile.fromPath('picture', filePath));

    var res = await request.send();
    return res.reasonPhrase;
  }

  static Future<String?> PUT(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response =
    await put(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);

    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response =
    await patch(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  static Future<Contact?> DELETE(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await delete(uri, headers: getHeaders());
    Log.d(response.body);
    if (response.statusCode == 200) return Contact.fromJson(jsonDecode(response.body));
    return null;
  }

  /* Http Apis */
  static String API_LIST = '/contact';
  static String API_ONE = '/contact/'; //{id}
  static String API_CREATE = '/contact';
  static String API_UPDATE = '/contact/'; //{id}
  static String API_DELETE = '/contact/'; //{id}

  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, dynamic> paramsCreate(Contact contact) {
    Map<String, dynamic> params = {};
    params.addAll({
      'name': contact.name,
      'number': contact.number
    });
    return params;
  }

  static Map<String, dynamic> paramsUpdate(Contact contact) {
    Map<String, dynamic> params = {};
    params.addAll({
      'id': contact.id,
      'name': contact.name,
      'number': contact.number,
    });
    return params;
  }

  /* Http Parsing */

  static List<Contact> parsePostList(String response) {
    var json = jsonDecode(response);
    var data = List<Contact>.from(json.map((x) => Contact.fromJson(x)));
    return data;
  }

  static Contact parsePostCreate(String response) {
    dynamic json = jsonDecode(response);
    var data = Contact.fromJson(json);
    return data;
  }
}