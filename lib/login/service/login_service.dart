import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginService {
  Future<String> login(String username, String password) async {
    final url = Uri.parse('http://localhost:8080/login');

    final body = jsonEncode({
      'email': username,
      'password': password,
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      // Sucesso - o login foi bem-sucedido
      final responseData = response.body;

      return responseData;
    } else {
      return '';
    }
  }
}
