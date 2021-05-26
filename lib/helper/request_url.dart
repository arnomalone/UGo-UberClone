import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestURL {
  static Future<dynamic> getRequest(Uri url) async {
    http.Response response = await http.get(url);
    try {
      if(response.statusCode == 200) {
        String jsonData = response.body;
        var decodedData = jsonDecode(jsonData);
        return decodedData;
      }
      else {
        return 'No Response';
      }
    }
    catch(e) {
      return 'Failed';
    }
  }
}