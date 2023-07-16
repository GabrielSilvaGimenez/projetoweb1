import 'dart:convert';

import 'package:http/http.dart' as http;

class CreateUserService {
  Future<String> createUser(
      String username, String password, String email) async {
    final url = Uri.parse('http://localhost:8080/users');

    final body = jsonEncode({
      'name': username,
      'password': password,
      'email': email,
    });

    final response = await http.put(
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
