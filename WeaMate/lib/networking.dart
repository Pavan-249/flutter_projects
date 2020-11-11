import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);
  String weather_info;
  Future<dynamic> helper() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      weather_info = response.body;
      var json_con = jsonDecode(weather_info);
      return json_con;
    }
  }
}
