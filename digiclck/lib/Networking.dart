import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);
  final url;

  Future<dynamic> jDecode() async {
    try {
      http.Response response = await http.get(url);
      var stub = response.body;
      var time_json = await jsonDecode(stub);
      return time_json;
    } catch (e) {
      print('Manish');
    }
  }
}
