import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "http://54.236.91.141:3100/api/";

  Future<dynamic> login(String username, String password) async {
    final data = {username, password};
    final url = '${apiUrl}usuario/login';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> postData(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
