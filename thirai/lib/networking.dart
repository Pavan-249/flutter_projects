import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final url;
  NetworkHelper({this.url});

  Future<dynamic> jDecode() async {
    http.Response response = await http.get(url);
    var json_stub = response.body;
    var json_dc = jsonDecode(json_stub);
    return json_dc;
  }
}
